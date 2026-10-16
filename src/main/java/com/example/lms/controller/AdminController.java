package com.example.lms.controller;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import com.example.lms.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private LiveClassService liveClassService;

    @Autowired
    private AuditLogService auditLogService;

    @Autowired
    private AnnouncementRepository announcementRepository;

    @Autowired
    private ContactMessageRepository contactMessageRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private LessonProgressRepository lessonProgressRepository;

    private String getCurrentAdminEmail() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return (auth != null) ? auth.getName() : null;
    }

    // ==========================================
    // 0. ADMIN PROFILE & DASHBOARD
    // ==========================================
    @GetMapping({"/dashboard", "/adashboard"})
    public String dashboard(HttpSession session, Model model) {
        String email = getCurrentAdminEmail();
        UserMaster admin = userService.getUserByEmail(email).orElse(null);
        if (admin != null) {
            session.setAttribute("userName", admin.getName());
            session.setAttribute("email", email);
            session.setAttribute("regNumber", admin.getRegistrationNumber());
            model.addAttribute("admin", admin);
        }

        long totalStudents = userService.countByRole("ROLE_STUDENT");
        long totalFaculty = userService.countByRole("ROLE_FACULTY");
        long totalCourses = courseService.countTotalCourses();
        long publishedCourses = courseService.countPublishedCourses();
        long totalEnrollments = courseService.countTotalEnrollments();
        long totalQuizzes = quizService.countTotalQuizzes();
        long totalLiveClasses = liveClassService.countTotalClasses();
        long totalMaterials = lessonRepository.findAll().stream().filter(l -> l.getMaterialUrl() != null && !l.getMaterialUrl().trim().isEmpty()).count();

        model.addAttribute("totalUsers", userService.countTotalUsers());
        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("totalFaculty", totalFaculty);
        model.addAttribute("totalCourses", totalCourses);
        model.addAttribute("publishedCourses", publishedCourses);
        model.addAttribute("totalEnrollments", totalEnrollments);
        model.addAttribute("totalQuizzes", totalQuizzes);
        model.addAttribute("totalLiveClasses", totalLiveClasses);
        model.addAttribute("totalMaterials", totalMaterials);
        model.addAttribute("recentLogs", auditLogService.getRecentLogs());

        return "admin/adashboard";
    }

    @GetMapping("/profile")
    public String adminProfile(Model model, HttpSession session,
                               @RequestParam(value = "success", required = false) String success,
                               @RequestParam(value = "pwdSuccess", required = false) String pwdSuccess,
                               @RequestParam(value = "pwdError", required = false) String pwdError) {
        String email = getCurrentAdminEmail();
        UserMaster admin = userService.getUserByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Admin user not found"));

        session.setAttribute("userName", admin.getName());
        session.setAttribute("email", email);
        session.setAttribute("regNumber", admin.getRegistrationNumber());

        model.addAttribute("admin", admin);
        model.addAttribute("totalStudents", userService.countByRole("ROLE_STUDENT"));
        model.addAttribute("totalFaculty", userService.countByRole("ROLE_FACULTY"));
        model.addAttribute("totalCourses", courseService.countTotalCourses());
        model.addAttribute("totalEnrollments", courseService.countTotalEnrollments());
        model.addAttribute("totalQuizzes", quizService.countTotalQuizzes());
        model.addAttribute("totalLiveClasses", liveClassService.countTotalClasses());

        if (success != null) model.addAttribute("profileSuccess", "Admin profile updated successfully.");
        if (pwdSuccess != null) model.addAttribute("pwdSuccessMessage", "Admin password changed successfully.");
        if (pwdError != null) model.addAttribute("pwdErrorMessage", pwdError);

        return "admin/profile";
    }

    @PostMapping("/profile/update")
    public String updateAdminProfile(@RequestParam("name") String name,
                                     @RequestParam(value = "mobile", required = false) String mobile,
                                     @RequestParam(value = "address", required = false) String address,
                                     @RequestParam(value = "city", required = false) String city,
                                     @RequestParam(value = "state", required = false) String state,
                                     @RequestParam(value = "country", required = false) String country,
                                     @RequestParam(value = "department", required = false) String department,
                                     @RequestParam(value = "designation", required = false) String designation,
                                     @RequestParam(value = "bio", required = false) String bio,
                                     @RequestParam(value = "profilePhoto", required = false) String profilePhoto,
                                     HttpServletRequest request) {
        String email = getCurrentAdminEmail();
        userService.updateAdminProfile(email, name, mobile, address, city, state, country, department, designation, bio, profilePhoto, request.getRemoteAddr());
        return "redirect:/admin/profile?success=true";
    }

    @PostMapping("/profile/change-password")
    public String changeAdminPassword(@RequestParam("currentPassword") String currentPassword,
                                      @RequestParam("newPassword") String newPassword,
                                      @RequestParam("confirmPassword") String confirmPassword,
                                      HttpServletRequest request) {
        String email = getCurrentAdminEmail();
        if (!newPassword.equals(confirmPassword)) {
            return "redirect:/admin/profile?pwdError=New+passwords+do+not+match.";
        }
        try {
            userService.changePassword(email, currentPassword, newPassword, request.getRemoteAddr());
            return "redirect:/admin/profile?pwdSuccess=true";
        } catch (Exception e) {
            return "redirect:/admin/profile?pwdError=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8);
        }
    }

    // ==========================================
    // 1. 👨🎓 STUDENT MANAGEMENT
    // ==========================================
    @GetMapping("/students")
    public String studentsList(@RequestParam(value = "search", required = false) String search,
                               @RequestParam(value = "msg", required = false) String msg,
                               Model model) {
        List<UserMaster> students = userService.getUsersByRole("ROLE_STUDENT");
        if (search != null && !search.trim().isEmpty()) {
            String q = search.trim().toLowerCase();
            students = students.stream()
                    .filter(s -> (s.getName() != null && s.getName().toLowerCase().contains(q))
                            || (s.getEmail() != null && s.getEmail().toLowerCase().contains(q))
                            || (s.getRegistrationNumber() != null && s.getRegistrationNumber().toLowerCase().contains(q))
                            || (s.getRollNumber() != null && s.getRollNumber().toLowerCase().contains(q)))
                    .collect(Collectors.toList());
        }

        // Map enrollment counts and quiz submissions per student
        Map<String, Integer> enrollmentCounts = new HashMap<>();
        Map<String, Integer> completedCounts = new HashMap<>();
        for (UserMaster s : students) {
            List<Enrollment> enrolls = courseService.getStudentEnrollments(s.getEmail());
            enrollmentCounts.put(s.getEmail(), enrolls.size());
            completedCounts.put(s.getEmail(), (int) enrolls.stream().filter(e -> e.getProgressPct() >= 100).count());
        }

        model.addAttribute("students", students);
        model.addAttribute("enrollmentCounts", enrollmentCounts);
        model.addAttribute("completedCounts", completedCounts);
        model.addAttribute("search", search);
        if (msg != null) model.addAttribute("successMsg", msg);

        return "admin/students";
    }

    @PostMapping("/students/add")
    public String addStudent(@RequestParam("name") String name,
                             @RequestParam("email") String email,
                             @RequestParam(value = "mobile", required = false) String mobile,
                             @RequestParam("password") String password,
                             @RequestParam(value = "registrationNumber", required = false) String registrationNumber,
                             @RequestParam(value = "rollNumber", required = false) String rollNumber,
                             @RequestParam(value = "program", defaultValue = "B.Tech CSE") String program,
                             @RequestParam(value = "department", defaultValue = "Department of Computer Science & Engineering") String department,
                             @RequestParam(value = "semester", defaultValue = "1st Semester") String semester,
                             @RequestParam(value = "academicYear", defaultValue = "1st Year") String academicYear,
                             @RequestParam(value = "batch", defaultValue = "2024 - 2028") String batch,
                             @RequestParam(value = "section", defaultValue = "Section A") String section,
                             HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.createStudent(name, email, mobile, password, registrationNumber, rollNumber, program, department, semester, academicYear, batch, section, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/students?msg=Student+added+successfully";
    }

    @GetMapping("/students/{id}")
    public String viewStudentDetails(@PathVariable("id") Long id, Model model) {
        UserMaster student = userService.getUserById(id).orElseThrow(() -> new IllegalArgumentException("Student not found"));
        List<Enrollment> enrollments = courseService.getStudentEnrollments(student.getEmail());
        List<QuizSubmission> submissions = quizService.getSubmissionsByStudent(student.getEmail());

        model.addAttribute("student", student);
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("submissions", submissions);
        return "admin/student-details";
    }

    @PostMapping("/students/{id}/update")
    public String updateStudentDetails(@PathVariable("id") Long id,
                                       @RequestParam("name") String name,
                                       @RequestParam(value = "mobile", required = false) String mobile,
                                       @RequestParam(value = "dob", required = false) String dob,
                                       @RequestParam(value = "gender", required = false) String gender,
                                       @RequestParam(value = "address", required = false) String address,
                                       @RequestParam(value = "city", required = false) String city,
                                       @RequestParam(value = "state", required = false) String state,
                                       @RequestParam(value = "country", required = false) String country,
                                       @RequestParam(value = "rollNumber", required = false) String rollNumber,
                                       @RequestParam(value = "program", required = false) String program,
                                       @RequestParam(value = "department", required = false) String department,
                                       @RequestParam(value = "semester", required = false) String semester,
                                       @RequestParam(value = "academicYear", required = false) String academicYear,
                                       @RequestParam(value = "batch", required = false) String batch,
                                       @RequestParam(value = "section", required = false) String section,
                                       @RequestParam(value = "bio", required = false) String bio,
                                       HttpServletRequest request) {
        UserMaster student = userService.getUserById(id).orElseThrow(() -> new IllegalArgumentException("Student not found"));
        userService.updateStudentProfile(student.getEmail(), name, mobile, dob, gender, address, city, state, country,
                rollNumber, program, department, semester, academicYear, batch, section, bio, student.getProfilePhoto(), request.getRemoteAddr());
        return "redirect:/admin/students/" + id + "?msg=Student+details+updated+successfully";
    }

    @PostMapping("/students/{id}/toggle-status")
    public String toggleStudentStatus(@PathVariable("id") Long id, HttpServletRequest request) {
        UserMaster student = userService.getUserById(id).orElse(null);
        if (student != null) {
            String newStatus = "ACTIVE".equalsIgnoreCase(student.getStatus()) ? "INACTIVE" : "ACTIVE";
            userService.updateStatus(id, newStatus, getCurrentAdminEmail(), request.getRemoteAddr());
        }
        return "redirect:/admin/students";
    }

    @PostMapping("/students/{id}/delete")
    public String deleteStudent(@PathVariable("id") Long id, HttpServletRequest request) {
        userService.deleteUser(id, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/students?msg=Student+deleted+successfully";
    }

    @PostMapping("/students/{id}/reset-password")
    public String resetStudentPassword(@PathVariable("id") Long id,
                                       @RequestParam("newPassword") String newPassword,
                                       HttpServletRequest request) {
        userService.resetUserPassword(id, newPassword, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/students?msg=Password+reset+successfully";
    }

    // ==========================================
    // 2. 👨🏫 FACULTY MANAGEMENT
    // ==========================================
    @GetMapping("/faculty")
    public String facultyList(@RequestParam(value = "search", required = false) String search,
                              @RequestParam(value = "msg", required = false) String msg,
                              Model model) {
        List<UserMaster> facultyList = userService.getUsersByRole("ROLE_FACULTY");
        if (search != null && !search.trim().isEmpty()) {
            String q = search.trim().toLowerCase();
            facultyList = facultyList.stream()
                    .filter(f -> (f.getName() != null && f.getName().toLowerCase().contains(q))
                            || (f.getEmail() != null && f.getEmail().toLowerCase().contains(q))
                            || (f.getDepartment() != null && f.getDepartment().toLowerCase().contains(q))
                            || (f.getDesignation() != null && f.getDesignation().toLowerCase().contains(q)))
                    .collect(Collectors.toList());
        }

        // Map course count and student count per faculty
        Map<String, Integer> courseCounts = new HashMap<>();
        Map<String, Integer> studentCounts = new HashMap<>();
        for (UserMaster f : facultyList) {
            List<Course> cList = courseService.getCoursesByInstructor(f.getEmail());
            List<Enrollment> eList = courseService.getInstructorEnrollments(f.getEmail());
            courseCounts.put(f.getEmail(), cList.size());
            studentCounts.put(f.getEmail(), eList.size());
        }

        List<Course> allCourses = courseService.getAllCourses();

        model.addAttribute("facultyList", facultyList);
        model.addAttribute("courseCounts", courseCounts);
        model.addAttribute("studentCounts", studentCounts);
        model.addAttribute("allCourses", allCourses);
        model.addAttribute("search", search);
        if (msg != null) model.addAttribute("successMsg", msg);

        return "admin/faculty";
    }

    @PostMapping("/faculty/add")
    public String addFaculty(@RequestParam("name") String name,
                             @RequestParam("email") String email,
                             @RequestParam(value = "mobile", required = false) String mobile,
                             @RequestParam("password") String password,
                             @RequestParam(value = "registrationNumber", required = false) String registrationNumber,
                             @RequestParam(value = "department", defaultValue = "Computer Science & Engineering") String department,
                             @RequestParam(value = "designation", defaultValue = "Assistant Professor") String designation,
                             @RequestParam(value = "qualification", defaultValue = "M.Tech / Ph.D.") String qualification,
                             @RequestParam(value = "specialization", defaultValue = "Computer Science") String specialization,
                             @RequestParam(value = "experience", defaultValue = "5+ Years") String experience,
                             @RequestParam(value = "joiningDate", required = false) String joiningDate,
                             HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.createFaculty(name, email, mobile, password, registrationNumber, department, designation, qualification, specialization, experience, joiningDate, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/faculty?msg=Faculty+added+successfully";
    }

    @GetMapping("/faculty/{id}")
    public String viewFacultyDetails(@PathVariable("id") Long id, Model model) {
        UserMaster faculty = userService.getUserById(id).orElseThrow(() -> new IllegalArgumentException("Faculty not found"));
        List<Course> courses = courseService.getCoursesByInstructor(faculty.getEmail());
        List<Enrollment> enrollments = courseService.getInstructorEnrollments(faculty.getEmail());
        List<LiveClass> liveClasses = liveClassService.getClassesByInstructor(faculty.getEmail());
        List<Quiz> quizzes = quizService.getQuizzesByInstructor(faculty.getEmail());

        model.addAttribute("faculty", faculty);
        model.addAttribute("courses", courses);
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("quizzes", quizzes);
        return "admin/faculty-details";
    }

    @PostMapping("/faculty/{id}/update")
    public String updateFacultyDetails(@PathVariable("id") Long id,
                                       @RequestParam("name") String name,
                                       @RequestParam(value = "mobile", required = false) String mobile,
                                       @RequestParam(value = "dob", required = false) String dob,
                                       @RequestParam(value = "gender", required = false) String gender,
                                       @RequestParam(value = "address", required = false) String address,
                                       @RequestParam(value = "city", required = false) String city,
                                       @RequestParam(value = "state", required = false) String state,
                                       @RequestParam(value = "country", required = false) String country,
                                       @RequestParam(value = "department", required = false) String department,
                                       @RequestParam(value = "designation", required = false) String designation,
                                       @RequestParam(value = "qualification", required = false) String qualification,
                                       @RequestParam(value = "specialization", required = false) String specialization,
                                       @RequestParam(value = "experience", required = false) String experience,
                                       @RequestParam(value = "joiningDate", required = false) String joiningDate,
                                       @RequestParam(value = "bio", required = false) String bio,
                                       HttpServletRequest request) {
        UserMaster faculty = userService.getUserById(id).orElseThrow(() -> new IllegalArgumentException("Faculty not found"));
        userService.updateFacultyProfile(faculty.getEmail(), name, mobile, dob, gender, address, city, state, country,
                department, designation, qualification, specialization, experience, joiningDate, bio, faculty.getProfilePhoto(), request.getRemoteAddr());
        return "redirect:/admin/faculty/" + id + "?msg=Faculty+details+updated+successfully";
    }

    @PostMapping("/faculty/{id}/toggle-status")
    public String toggleFacultyStatus(@PathVariable("id") Long id, HttpServletRequest request) {
        UserMaster faculty = userService.getUserById(id).orElse(null);
        if (faculty != null) {
            String newStatus = "ACTIVE".equalsIgnoreCase(faculty.getStatus()) ? "INACTIVE" : "ACTIVE";
            userService.updateStatus(id, newStatus, getCurrentAdminEmail(), request.getRemoteAddr());
        }
        return "redirect:/admin/faculty";
    }

    @PostMapping("/faculty/{id}/delete")
    public String deleteFaculty(@PathVariable("id") Long id, HttpServletRequest request) {
        userService.deleteUser(id, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/faculty?msg=Faculty+deleted+successfully";
    }

    @PostMapping("/faculty/{id}/reset-password")
    public String resetFacultyPassword(@PathVariable("id") Long id,
                                       @RequestParam("newPassword") String newPassword,
                                       HttpServletRequest request) {
        userService.resetUserPassword(id, newPassword, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/faculty?msg=Password+reset+successfully";
    }

    @PostMapping("/faculty/assign-course")
    public String assignCourseToFaculty(@RequestParam("courseId") Long courseId,
                                        @RequestParam("facultyEmail") String facultyEmail,
                                        HttpServletRequest request) {
        UserMaster faculty = userService.getUserByEmail(facultyEmail).orElse(null);
        String facultyName = (faculty != null) ? faculty.getName() : "Faculty";
        courseService.assignFacultyToCourse(courseId, facultyEmail, facultyName, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/faculty?msg=Course+assigned+successfully";
    }

    // ==========================================
    // 3. 📚 COURSE MANAGEMENT
    // ==========================================
    @GetMapping("/courses")
    public String allCourses(Model model) {
        List<Course> courses = courseService.getAllCourses();
        List<UserMaster> facultyList = userService.getUsersByRole("ROLE_FACULTY");
        List<Category> categories = courseService.getAllCategories();

        Map<Long, Integer> enrollmentCounts = new HashMap<>();
        for (Course c : courses) {
            enrollmentCounts.put(c.getId(), enrollmentRepository.findByCourseId(c.getId()).size());
        }

        model.addAttribute("courses", courses);
        model.addAttribute("facultyList", facultyList);
        model.addAttribute("categories", categories);
        model.addAttribute("enrollmentCounts", enrollmentCounts);
        return "admin/courses";
    }

    @PostMapping("/courses/create")
    public String createCourse(@RequestParam("title") String title,
                               @RequestParam("description") String description,
                               @RequestParam("level") String level,
                               @RequestParam(value = "duration", defaultValue = "8 Weeks") String duration,
                               @RequestParam(value = "price", defaultValue = "Free") String price,
                               @RequestParam(value = "thumbnailUrl", required = false) String thumbnailUrl,
                               @RequestParam("categoryId") Long categoryId,
                               @RequestParam("facultyEmail") String facultyEmail,
                               HttpServletRequest request) {
        UserMaster faculty = userService.getUserByEmail(facultyEmail).orElse(null);
        String instructorName = (faculty != null) ? faculty.getName() : "Faculty";
        courseService.createCourse(title, description, level, duration, price, thumbnailUrl, categoryId, facultyEmail, instructorName, request.getRemoteAddr());
        return "redirect:/admin/courses";
    }

    @PostMapping("/courses/{id}/edit")
    public String editCourse(@PathVariable("id") Long id,
                             @RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam("level") String level,
                             @RequestParam(value = "duration", defaultValue = "8 Weeks") String duration,
                             @RequestParam(value = "price", defaultValue = "Free") String price,
                             @RequestParam(value = "thumbnailUrl", required = false) String thumbnailUrl,
                             @RequestParam("categoryId") Long categoryId,
                             @RequestParam("facultyEmail") String facultyEmail,
                             @RequestParam(value = "published", defaultValue = "true") boolean published,
                             HttpServletRequest request) {
        UserMaster faculty = userService.getUserByEmail(facultyEmail).orElse(null);
        String instructorName = (faculty != null) ? faculty.getName() : "Faculty";

        courseService.updateCourse(id, title, description, level, duration, price, thumbnailUrl, categoryId, published, getCurrentAdminEmail(), request.getRemoteAddr());
        courseService.assignFacultyToCourse(id, facultyEmail, instructorName, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/courses";
    }

    @PostMapping("/courses/{id}/toggle-publish")
    public String toggleCoursePublish(@PathVariable("id") Long id, HttpServletRequest request) {
        Course course = courseService.getCourseById(id).orElse(null);
        if (course != null) {
            courseService.updateCourse(id, course.getTitle(), course.getDescription(), course.getLevel(),
                    course.getDuration(), course.getPrice(), course.getThumbnailUrl(),
                    course.getCategory() != null ? course.getCategory().getId() : null,
                    !course.isPublished(), getCurrentAdminEmail(), request.getRemoteAddr());
        }
        return "redirect:/admin/courses";
    }

    @PostMapping("/courses/{id}/delete")
    public String deleteCourse(@PathVariable("id") Long id, HttpServletRequest request) {
        courseService.deleteCourse(id, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/courses";
    }

    // ==========================================
    // 4. 📖 STUDY MATERIAL MANAGEMENT
    // ==========================================
    @GetMapping("/materials")
    public String studyMaterials(Model model) {
        List<Lesson> lessons = courseService.getAllLessonsWithMaterials();
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("lessons", lessons);
        model.addAttribute("courses", courses);
        return "admin/materials";
    }

    @PostMapping("/materials/{id}/update")
    public String updateMaterial(@PathVariable("id") Long lessonId,
                                 @RequestParam("materialUrl") String materialUrl,
                                 @RequestParam("materialName") String materialName,
                                 HttpServletRequest request) {
        courseService.updateLessonMaterial(lessonId, materialUrl, materialName, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/materials?msg=Material+updated+successfully";
    }

    @PostMapping("/materials/{id}/delete")
    public String deleteMaterial(@PathVariable("id") Long lessonId, HttpServletRequest request) {
        courseService.deleteLesson(lessonId, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/materials?msg=Material+removed+successfully";
    }

    // ==========================================
    // 5. 📝 QUIZ & ASSIGNMENT MANAGEMENT
    // ==========================================
    @GetMapping("/quizzes")
    public String allQuizzes(Model model) {
        List<Quiz> quizzes = quizService.getAllQuizzes();
        List<Course> courses = courseService.getAllCourses();
        List<QuizSubmission> submissions = quizService.getAllSubmissions();

        model.addAttribute("quizzes", quizzes);
        model.addAttribute("courses", courses);
        model.addAttribute("submissions", submissions);
        return "admin/quizzes";
    }

    @PostMapping("/quizzes/create")
    public String createQuiz(@RequestParam("courseId") Long courseId,
                             @RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam(value = "timeLimitMinutes", defaultValue = "20") int timeLimitMinutes,
                             @RequestParam(value = "passingScorePct", defaultValue = "60") int passingScorePct,
                             HttpServletRequest request) {
        quizService.createQuiz(courseId, title, description, timeLimitMinutes, passingScorePct, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/quizzes?msg=Quiz+created+successfully";
    }

    @PostMapping("/quizzes/{id}/delete")
    public String deleteQuiz(@PathVariable("id") Long id, HttpServletRequest request) {
        quizService.deleteQuiz(id, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/quizzes?msg=Quiz+deleted+successfully";
    }

    @GetMapping("/submissions")
    public String allSubmissions(Model model) {
        List<QuizSubmission> submissions = quizService.getAllSubmissions();
        model.addAttribute("submissions", submissions);
        return "admin/submissions";
    }

    // ==========================================
    // 6. 🎥 LIVE CLASS MANAGEMENT
    // ==========================================
    @GetMapping("/live")
    public String liveClasses(Model model) {
        List<LiveClass> liveClasses = liveClassService.getAllClasses();
        List<Course> courses = courseService.getAllCourses();
        List<UserMaster> facultyList = userService.getUsersByRole("ROLE_FACULTY");

        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("courses", courses);
        model.addAttribute("facultyList", facultyList);
        return "admin/live";
    }

    @PostMapping("/live/schedule")
    public String scheduleLiveClass(@RequestParam("courseId") Long courseId,
                                    @RequestParam("instructorEmail") String instructorEmail,
                                    @RequestParam("title") String title,
                                    @RequestParam("description") String description,
                                    @RequestParam("scheduledAt") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime scheduledAt,
                                    @RequestParam(value = "durationMinutes", defaultValue = "60") int durationMinutes,
                                    HttpServletRequest request) {
        liveClassService.scheduleClass(courseId, instructorEmail, title, description, scheduledAt, durationMinutes, request.getRemoteAddr());
        return "redirect:/admin/live?msg=Live+class+scheduled+successfully";
    }

    @PostMapping("/live/{id}/status")
    public String updateLiveStatus(@PathVariable("id") Long id,
                                   @RequestParam("status") String status,
                                   HttpServletRequest request) {
        liveClassService.updateStatus(id, status, getCurrentAdminEmail(), request.getRemoteAddr());
        return "redirect:/admin/live?msg=Live+class+status+updated";
    }

    // ==========================================
    // 7. 📊 DASHBOARD & REPORTS
    // ==========================================
    @GetMapping("/reports")
    public String reportsAndAnalytics(Model model) {
        List<UserMaster> students = userService.getUsersByRole("ROLE_STUDENT");
        List<UserMaster> facultyList = userService.getUsersByRole("ROLE_FACULTY");
        List<Course> courses = courseService.getAllCourses();
        List<Enrollment> enrollments = enrollmentRepository.findAll();
        List<QuizSubmission> submissions = quizService.getAllSubmissions();
        List<LiveClass> liveClasses = liveClassService.getAllClasses();

        double avgQuizScore = submissions.isEmpty() ? 0 : submissions.stream().mapToDouble(QuizSubmission::getScorePct).average().orElse(0);
        long passedCount = submissions.stream().filter(s -> "PASS".equalsIgnoreCase(s.getStatus())).count();
        double passRate = submissions.isEmpty() ? 0 : ((double) passedCount / submissions.size()) * 100;
        long completedEnrollments = enrollments.stream().filter(e -> e.getProgressPct() >= 100).count();
        double completionRate = enrollments.isEmpty() ? 0 : ((double) completedEnrollments / enrollments.size()) * 100;

        model.addAttribute("totalStudents", students.size());
        model.addAttribute("totalFaculty", facultyList.size());
        model.addAttribute("totalCourses", courses.size());
        model.addAttribute("publishedCourses", courses.stream().filter(Course::isPublished).count());
        model.addAttribute("totalEnrollments", enrollments.size());
        model.addAttribute("totalQuizzes", quizService.countTotalQuizzes());
        model.addAttribute("totalLiveClasses", liveClasses.size());
        model.addAttribute("avgQuizScore", Math.round(avgQuizScore * 10.0) / 10.0);
        model.addAttribute("passRate", Math.round(passRate * 10.0) / 10.0);
        model.addAttribute("completionRate", Math.round(completionRate * 10.0) / 10.0);
        model.addAttribute("courses", courses);
        model.addAttribute("students", students);
        model.addAttribute("submissions", submissions);

        return "admin/reports";
    }

    // ==========================================
    // 8. ⚙️ SYSTEM MANAGEMENT & SETTINGS
    // ==========================================
    @GetMapping({"/system", "/settings"})
    public String systemManagement(Model model) {
        model.addAttribute("totalUsers", userService.countTotalUsers());
        model.addAttribute("categories", courseService.getAllCategories());
        model.addAttribute("announcements", announcementRepository.findAllByOrderByCreatedAtDesc());
        model.addAttribute("auditLogs", auditLogService.getRecentLogs());
        return "admin/system";
    }

    @GetMapping("/users")
    public String usersList(@RequestParam(value = "role", required = false) String roleFilter,
                            Model model) {
        List<UserMaster> users;
        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
            users = userService.getUsersByRole(roleFilter);
        } else {
            users = userService.getAllUsers();
        }

        model.addAttribute("users", users);
        model.addAttribute("selectedRole", roleFilter);
        return "admin/users";
    }

    @PostMapping("/users/{id}/status")
    public String updateUserStatus(@PathVariable("id") Long userId,
                                   @RequestParam("status") String status,
                                   HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.updateStatus(userId, status, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{id}/role")
    public String updateUserRole(@PathVariable("id") Long userId,
                                 @RequestParam("role") String role,
                                 HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.updateRole(userId, role, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/users";
    }

    @PostMapping("/users/{id}/delete")
    public String deleteUser(@PathVariable("id") Long userId, HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.deleteUser(userId, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/users";
    }

    @GetMapping("/registrations")
    public String verifiedRegistrations(Model model) {
        model.addAttribute("registrations", userService.getAllVerifiedRegistrations());
        return "admin/registrations";
    }

    @PostMapping("/registrations/add")
    public String addVerifiedRegistration(@RequestParam("registrationNumber") String registrationNumber,
                                          @RequestParam("role") String role,
                                          @RequestParam(value = "allocatedName", required = false) String allocatedName,
                                          @RequestParam(value = "department", required = false) String department,
                                          HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        try {
            userService.addVerifiedRegistration(registrationNumber, role, allocatedName, department, adminEmail, request.getRemoteAddr());
        } catch (Exception e) {
            // Duplicate
        }
        return "redirect:/admin/registrations";
    }

    @PostMapping("/registrations/{id}/delete")
    public String deleteVerifiedRegistration(@PathVariable("id") Long id, HttpServletRequest request) {
        String adminEmail = getCurrentAdminEmail();
        userService.deleteVerifiedRegistration(id, adminEmail, request.getRemoteAddr());
        return "redirect:/admin/registrations";
    }

    @GetMapping("/categories")
    public String categories(Model model) {
        model.addAttribute("categories", courseService.getAllCategories());
        return "admin/categories";
    }

    @PostMapping("/categories/add")
    public String addCategory(@RequestParam("name") String name,
                              @RequestParam("description") String description,
                              @RequestParam(value = "icon", defaultValue = "fa-book") String icon) {
        courseService.createCategory(name, description, icon);
        return "redirect:/admin/categories";
    }

    @GetMapping("/audit-logs")
    public String auditLogs(Model model) {
        model.addAttribute("logs", auditLogService.getAllLogs());
        return "admin/audit-logs";
    }

    @GetMapping("/announcements")
    public String announcements(Model model) {
        model.addAttribute("announcements", announcementRepository.findAllByOrderByCreatedAtDesc());
        return "admin/announcements";
    }

    @PostMapping("/announcements/add")
    public String addAnnouncement(@RequestParam("title") String title,
                                  @RequestParam("content") String content,
                                  @RequestParam(value = "targetRole", defaultValue = "ALL") String targetRole) {
        String adminEmail = getCurrentAdminEmail();
        announcementRepository.save(new Announcement(title, content, targetRole, adminEmail));
        return "redirect:/admin/announcements";
    }

    @GetMapping("/messages")
    public String contactMessages(Model model) {
        model.addAttribute("messages", contactMessageRepository.findAllByOrderByCreatedAtDesc());
        return "admin/messages";
    }

    @PostMapping("/messages/{id}/resolve")
    public String resolveMessage(@PathVariable("id") Long id) {
        contactMessageRepository.findById(id).ifPresent(msg -> {
            msg.setStatus("RESOLVED");
            contactMessageRepository.save(msg);
        });
        return "redirect:/admin/messages";
    }
}
