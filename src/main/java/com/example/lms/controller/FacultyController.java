package com.example.lms.controller;

import com.example.lms.model.*;
import com.example.lms.service.CourseService;
import com.example.lms.service.LiveClassService;
import com.example.lms.service.QuizService;
import com.example.lms.service.UserService;
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
import java.util.List;

@Controller
@RequestMapping("/faculty")
public class FacultyController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private LiveClassService liveClassService;

    @Autowired
    private UserService userService;

    private String getCurrentFacultyEmail() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return (auth != null) ? auth.getName() : null;
    }

    @GetMapping({"/dashboard", "/fdashboard"})
    public String dashboard(HttpSession session, Model model) {
        String email = getCurrentFacultyEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        if (user != null) {
            session.setAttribute("userName", user.getName());
            session.setAttribute("email", email);
            model.addAttribute("faculty", user);
        }

        List<Course> courses = courseService.getCoursesByInstructor(email);
        List<Enrollment> enrollments = courseService.getInstructorEnrollments(email);
        List<QuizSubmission> submissions = quizService.getSubmissionsByInstructor(email);
        List<LiveClass> liveClasses = liveClassService.getClassesByInstructor(email);

        model.addAttribute("courses", courses);
        model.addAttribute("totalCourses", courses.size());
        model.addAttribute("totalStudents", enrollments.size());
        model.addAttribute("totalSubmissions", submissions.size());
        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("recentSubmissions", submissions.stream().limit(5).toList());

        return "faculty/fdashboard";
    }

    @GetMapping("/courses")
    public String courses(Model model) {
        String email = getCurrentFacultyEmail();
        List<Course> courses = courseService.getCoursesByInstructor(email);
        model.addAttribute("courses", courses);
        return "faculty/courses";
    }

    @GetMapping("/courses/create")
    public String createCourseForm(Model model) {
        model.addAttribute("categories", courseService.getAllCategories());
        return "faculty/course-create";
    }

    @PostMapping("/courses/create")
    public String createCourse(@RequestParam("title") String title,
                               @RequestParam("description") String description,
                               @RequestParam("level") String level,
                               @RequestParam(value = "duration", defaultValue = "8 Weeks") String duration,
                               @RequestParam(value = "price", defaultValue = "Free") String price,
                               @RequestParam(value = "thumbnailUrl", required = false) String thumbnailUrl,
                               @RequestParam("categoryId") Long categoryId,
                               HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        String instructorName = (user != null) ? user.getName() : "Faculty";

        Course course = courseService.createCourse(title, description, level, duration, price, thumbnailUrl, categoryId, email, instructorName, request.getRemoteAddr());
        return "redirect:/faculty/courses/" + course.getId() + "/builder";
    }

    @GetMapping("/courses/{id}/builder")
    public String courseBuilder(@PathVariable("id") Long id, Model model) {
        Course course = courseService.getCourseById(id)
                .orElseThrow(() -> new IllegalArgumentException("Course not found"));
        model.addAttribute("course", course);
        return "faculty/course-builder";
    }

    @PostMapping("/courses/{id}/sections/add")
    public String addSection(@PathVariable("id") Long courseId,
                             @RequestParam("title") String title,
                             @RequestParam(value = "orderNum", defaultValue = "1") int orderNum) {
        courseService.addSection(courseId, title, orderNum);
        return "redirect:/faculty/courses/" + courseId + "/builder";
    }

    @PostMapping("/sections/{id}/lessons/add")
    public String addLesson(@PathVariable("id") Long sectionId,
                            @RequestParam("courseId") Long courseId,
                            @RequestParam("title") String title,
                            @RequestParam(value = "orderNum", defaultValue = "1") int orderNum,
                            @RequestParam(value = "videoUrl", required = false) String videoUrl,
                            @RequestParam(value = "contentText", required = false) String contentText,
                            @RequestParam(value = "materialUrl", required = false) String materialUrl,
                            @RequestParam(value = "materialName", required = false) String materialName,
                            @RequestParam(value = "durationMinutes", defaultValue = "15") int durationMinutes) {
        courseService.addLesson(sectionId, title, orderNum, videoUrl, contentText, materialUrl, materialName, durationMinutes);
        return "redirect:/faculty/courses/" + courseId + "/builder";
    }

    @PostMapping("/courses/{id}/toggle-publish")
    public String togglePublish(@PathVariable("id") Long id, HttpServletRequest request) {
        Course course = courseService.getCourseById(id).orElse(null);
        if (course != null) {
            courseService.updateCourse(id, course.getTitle(), course.getDescription(), course.getLevel(),
                    course.getThumbnailUrl(), course.getCategory() != null ? course.getCategory().getId() : null,
                    !course.isPublished(), getCurrentFacultyEmail(), request.getRemoteAddr());
        }
        return "redirect:/faculty/courses";
    }

    @GetMapping("/quizzes")
    public String quizzes(Model model) {
        String email = getCurrentFacultyEmail();
        List<Quiz> quizzes = quizService.getQuizzesByInstructor(email);
        List<Course> courses = courseService.getCoursesByInstructor(email);
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("courses", courses);
        return "faculty/quizzes";
    }

    @PostMapping("/quizzes/create")
    public String createQuiz(@RequestParam("courseId") Long courseId,
                             @RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam(value = "timeLimitMinutes", defaultValue = "15") int timeLimitMinutes,
                             @RequestParam(value = "passingScorePct", defaultValue = "60") int passingScorePct,
                             HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        Quiz quiz = quizService.createQuiz(courseId, title, description, timeLimitMinutes, passingScorePct, email, request.getRemoteAddr());
        return "redirect:/faculty/quizzes/" + quiz.getId() + "/questions";
    }

    @GetMapping("/quizzes/{id}/questions")
    public String questionAuthoring(@PathVariable("id") Long id, Model model) {
        Quiz quiz = quizService.getQuizById(id)
                .orElseThrow(() -> new IllegalArgumentException("Quiz not found"));
        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", quiz.getQuestions());
        return "faculty/quiz-questions";
    }

    @PostMapping("/quizzes/{id}/questions/add")
    public String addQuestion(@PathVariable("id") Long quizId,
                              @RequestParam("questionText") String questionText,
                              @RequestParam("optionA") String optionA,
                              @RequestParam("optionB") String optionB,
                              @RequestParam("optionC") String optionC,
                              @RequestParam("optionD") String optionD,
                              @RequestParam("correctAnswer") String correctAnswer,
                              @RequestParam(value = "points", defaultValue = "1") int points,
                              @RequestParam(value = "explanation", required = false) String explanation) {
        quizService.addQuestion(quizId, questionText, optionA, optionB, optionC, optionD, correctAnswer, points, explanation);
        return "redirect:/faculty/quizzes/" + quizId + "/questions";
    }

    @GetMapping("/live")
    public String liveSchedule(Model model) {
        String email = getCurrentFacultyEmail();
        List<LiveClass> liveClasses = liveClassService.getClassesByInstructor(email);
        List<Course> courses = courseService.getCoursesByInstructor(email);
        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("courses", courses);
        return "faculty/live";
    }

    @PostMapping("/live/schedule")
    public String scheduleLiveClass(@RequestParam("courseId") Long courseId,
                                    @RequestParam("title") String title,
                                    @RequestParam("description") String description,
                                    @RequestParam("scheduledAt") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime scheduledAt,
                                    @RequestParam(value = "durationMinutes", defaultValue = "60") int durationMinutes,
                                    HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        liveClassService.scheduleClass(courseId, email, title, description, scheduledAt, durationMinutes, request.getRemoteAddr());
        return "redirect:/faculty/live";
    }

    @PostMapping("/live/{id}/status")
    public String updateLiveStatus(@PathVariable("id") Long id,
                                   @RequestParam("status") String status,
                                   HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        liveClassService.updateStatus(id, status, email, request.getRemoteAddr());
        return "redirect:/faculty/live";
    }

    @GetMapping("/live/{id}/broadcast")
    public String startBroadcast(@PathVariable("id") Long id, Model model) {
        String email = getCurrentFacultyEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        LiveClass liveClass = liveClassService.getClassById(id)
                .orElseThrow(() -> new IllegalArgumentException("Live class not found"));

        model.addAttribute("liveClass", liveClass);
        model.addAttribute("userName", (user != null) ? user.getName() : "Instructor");
        return "faculty/live-broadcast";
    }

    @GetMapping("/analytics")
    public String facultyAnalytics(Model model) {
        String email = getCurrentFacultyEmail();
        List<QuizSubmission> submissions = quizService.getSubmissionsByInstructor(email);
        List<Course> courses = courseService.getCoursesByInstructor(email);
        List<Enrollment> enrollments = courseService.getInstructorEnrollments(email);

        double avgScore = submissions.isEmpty() ? 0 : submissions.stream().mapToDouble(QuizSubmission::getScorePct).average().orElse(0);
        long passedCount = submissions.stream().filter(s -> "PASS".equalsIgnoreCase(s.getStatus())).count();
        double passRate = submissions.isEmpty() ? 0 : ((double) passedCount / submissions.size()) * 100;

        model.addAttribute("submissions", submissions);
        model.addAttribute("courses", courses);
        model.addAttribute("totalStudents", enrollments.size());
        model.addAttribute("avgScore", Math.round(avgScore * 10.0) / 10.0);
        model.addAttribute("passRate", Math.round(passRate * 10.0) / 10.0);

        return "faculty/analytics";
    }

    @GetMapping("/profile")
    public String facultyProfile(Model model, HttpSession session,
                                 @RequestParam(value = "success", required = false) String success,
                                 @RequestParam(value = "pwdSuccess", required = false) String pwdSuccess,
                                 @RequestParam(value = "pwdError", required = false) String pwdError) {
        String email = getCurrentFacultyEmail();
        UserMaster faculty = userService.getUserByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Faculty not found"));

        session.setAttribute("userName", faculty.getName());
        session.setAttribute("email", email);
        session.setAttribute("regNumber", faculty.getRegistrationNumber());

        List<Course> courses = courseService.getCoursesByInstructor(email);
        List<Enrollment> enrollments = courseService.getInstructorEnrollments(email);
        List<QuizSubmission> submissions = quizService.getSubmissionsByInstructor(email);
        List<LiveClass> liveClasses = liveClassService.getClassesByInstructor(email);
        List<Quiz> quizzes = quizService.getQuizzesByInstructor(email);

        int totalMaterials = 0;
        for (Course c : courses) {
            if (c.getSections() != null) {
                for (Section s : c.getSections()) {
                    if (s.getLessons() != null) {
                        for (Lesson l : s.getLessons()) {
                            if (l.getMaterialUrl() != null && !l.getMaterialUrl().trim().isEmpty()) {
                                totalMaterials++;
                            }
                        }
                    }
                }
            }
        }

        double avgScore = submissions.isEmpty() ? 0 : submissions.stream().mapToDouble(QuizSubmission::getScorePct).average().orElse(0);
        long passedCount = submissions.stream().filter(s -> "PASS".equalsIgnoreCase(s.getStatus())).count();
        double passRate = submissions.isEmpty() ? 0 : ((double) passedCount / submissions.size()) * 100;

        model.addAttribute("faculty", faculty);
        model.addAttribute("courses", courses);
        model.addAttribute("totalCourses", courses.size());
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("totalStudents", enrollments.size());
        model.addAttribute("submissions", submissions);
        model.addAttribute("totalSubmissions", submissions.size());
        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("totalMaterials", totalMaterials);
        model.addAttribute("avgScore", Math.round(avgScore * 10.0) / 10.0);
        model.addAttribute("passRate", Math.round(passRate * 10.0) / 10.0);

        if (success != null) model.addAttribute("profileSuccess", "Your profile details have been successfully updated.");
        if (pwdSuccess != null) model.addAttribute("pwdSuccessMessage", "Your password has been changed successfully.");
        if (pwdError != null) model.addAttribute("pwdErrorMessage", pwdError);

        return "faculty/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("name") String name,
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
                                @RequestParam(value = "profilePhoto", required = false) String profilePhoto,
                                HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        userService.updateFacultyProfile(email, name, mobile, dob, gender, address, city, state, country,
                department, designation, qualification, specialization, experience, joiningDate, bio, profilePhoto, request.getRemoteAddr());
        return "redirect:/faculty/profile?success=true";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpServletRequest request) {
        String email = getCurrentFacultyEmail();
        if (!newPassword.equals(confirmPassword)) {
            return "redirect:/faculty/profile?pwdError=New+passwords+do+not+match.";
        }
        try {
            userService.changePassword(email, currentPassword, newPassword, request.getRemoteAddr());
            return "redirect:/faculty/profile?pwdSuccess=true";
        } catch (Exception e) {
            return "redirect:/faculty/profile?pwdError=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8);
        }
    }
}
