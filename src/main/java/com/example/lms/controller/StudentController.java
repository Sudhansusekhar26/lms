package com.example.lms.controller;

import com.example.lms.model.*;
import com.example.lms.repository.AnnouncementRepository;
import com.example.lms.repository.LessonProgressRepository;
import com.example.lms.repository.LessonRepository;
import com.example.lms.service.CourseService;
import com.example.lms.service.LiveClassService;
import com.example.lms.service.QuizService;
import com.example.lms.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private LiveClassService liveClassService;

    @Autowired
    private UserService userService;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private LessonProgressRepository lessonProgressRepository;

    @Autowired
    private AnnouncementRepository announcementRepository;

    private String getCurrentStudentEmail() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return (auth != null) ? auth.getName() : null;
    }

    @GetMapping({"/dashboard", "/sdashboard"})
    public String dashboard(HttpSession session, Model model) {
        String email = getCurrentStudentEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        if (user != null) {
            session.setAttribute("userName", user.getName());
            session.setAttribute("email", email);
            model.addAttribute("student", user);
        }

        List<Enrollment> enrollments = courseService.getStudentEnrollments(email);
        List<QuizSubmission> submissions = quizService.getSubmissionsByStudent(email);
        List<LiveClass> liveClasses = liveClassService.getUpcomingClasses();
        List<Announcement> announcements = announcementRepository.findByTargetRoleInOrderByCreatedAtDesc(Arrays.asList("ALL", "STUDENT"));

        int totalEnrolled = enrollments.size();
        int completedCourses = (int) enrollments.stream().filter(e -> e.getProgressPct() >= 100).count();
        double avgScore = submissions.isEmpty() ? 0 : submissions.stream().mapToDouble(QuizSubmission::getScorePct).average().orElse(0);

        model.addAttribute("enrollments", enrollments);
        model.addAttribute("submissions", submissions);
        model.addAttribute("liveClasses", liveClasses);
        model.addAttribute("announcements", announcements);
        model.addAttribute("totalEnrolled", totalEnrolled);
        model.addAttribute("completedCourses", completedCourses);
        model.addAttribute("avgScore", Math.round(avgScore * 10.0) / 10.0);

        return "student/sdashboard";
    }

    @GetMapping("/courses")
    public String myCourses(Model model) {
        String email = getCurrentStudentEmail();
        List<Enrollment> enrollments = courseService.getStudentEnrollments(email);
        List<Course> allPublished = courseService.getAllPublishedCourses();

        Set<Long> enrolledCourseIds = enrollments.stream()
                .map(e -> e.getCourse().getId())
                .collect(Collectors.toSet());

        List<Course> discoverCourses = allPublished.stream()
                .filter(c -> !enrolledCourseIds.contains(c.getId()))
                .collect(Collectors.toList());

        model.addAttribute("enrollments", enrollments);
        model.addAttribute("discoverCourses", discoverCourses);
        return "student/courses";
    }

    @PostMapping("/enroll/{courseId}")
    public String enrollInCourse(@PathVariable("courseId") Long courseId, HttpServletRequest request) {
        String email = getCurrentStudentEmail();
        Course course = courseService.getCourseById(courseId).orElse(null);
        if (course != null && course.isUpcoming()) {
            return "redirect:/courses/" + courseId + "?upcoming=true";
        }
        courseService.enrollStudent(email, courseId, request.getRemoteAddr());
        return "redirect:/student/courses/" + courseId + "/learn";
    }

    @GetMapping("/courses/{courseId}/learn")
    public String coursePlayer(@PathVariable("courseId") Long courseId,
                               @RequestParam(value = "lessonId", required = false) Long lessonId,
                               Model model, HttpServletRequest request) {
        String email = getCurrentStudentEmail();
        Course course = courseService.getCourseById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found"));

        if (course.isUpcoming() && !courseService.isStudentEnrolled(email, courseId)) {
            return "redirect:/courses/" + courseId + "?upcoming=true";
        }

        if (!courseService.isStudentEnrolled(email, courseId)) {
            courseService.enrollStudent(email, courseId, request.getRemoteAddr());
        }

        List<LessonProgress> completedProgress = lessonProgressRepository.findByStudentEmailAndCourseId(email, courseId);
        Set<Long> completedLessonIds = completedProgress.stream()
                .filter(LessonProgress::isCompleted)
                .map(LessonProgress::getLessonId)
                .collect(Collectors.toSet());

        // Find active lesson
        Lesson currentLesson = null;
        if (lessonId != null) {
            currentLesson = lessonRepository.findById(lessonId).orElse(null);
        }

        if (currentLesson == null && course.getSections() != null && !course.getSections().isEmpty()) {
            for (Section sec : course.getSections()) {
                if (sec.getLessons() != null && !sec.getLessons().isEmpty()) {
                    currentLesson = sec.getLessons().get(0);
                    break;
                }
            }
        }

        Enrollment enrollment = courseService.getStudentEnrollments(email).stream()
                .filter(e -> e.getCourse().getId().equals(courseId))
                .findFirst().orElse(null);

        model.addAttribute("course", course);
        model.addAttribute("currentLesson", currentLesson);
        model.addAttribute("completedLessonIds", completedLessonIds);
        model.addAttribute("enrollment", enrollment);

        return "student/player";
    }

    @PostMapping("/lessons/{lessonId}/complete")
    public String markLessonComplete(@PathVariable("lessonId") Long lessonId,
                                     @RequestParam("courseId") Long courseId) {
        String email = getCurrentStudentEmail();
        courseService.markLessonComplete(email, lessonId, courseId);
        return "redirect:/student/courses/" + courseId + "/learn?lessonId=" + lessonId;
    }

    @GetMapping("/quizzes")
    public String quizzesList(Model model) {
        String email = getCurrentStudentEmail();
        List<Enrollment> enrollments = courseService.getStudentEnrollments(email);
        List<Quiz> availableQuizzes = new ArrayList<>();
        for (Enrollment e : enrollments) {
            availableQuizzes.addAll(quizService.getQuizzesByCourse(e.getCourse().getId()));
        }

        List<QuizSubmission> submissions = quizService.getSubmissionsByStudent(email);
        Map<Long, QuizSubmission> latestSubmissionMap = new HashMap<>();
        for (QuizSubmission sub : submissions) {
            latestSubmissionMap.putIfAbsent(sub.getQuiz().getId(), sub);
        }

        model.addAttribute("quizzes", availableQuizzes);
        model.addAttribute("submissionMap", latestSubmissionMap);
        model.addAttribute("allSubmissions", submissions);
        return "student/quizzes";
    }

    @GetMapping("/quizzes/{quizId}/start")
    public String startQuiz(@PathVariable("quizId") Long quizId, Model model) {
        Quiz quiz = quizService.getQuizById(quizId)
                .orElseThrow(() -> new IllegalArgumentException("Quiz not found"));

        model.addAttribute("quiz", quiz);
        model.addAttribute("questions", quiz.getQuestions());
        return "student/quiz-runner";
    }

    @PostMapping("/quizzes/{quizId}/submit")
    public String submitQuiz(@PathVariable("quizId") Long quizId,
                             @RequestParam Map<String, String> allParams,
                             HttpServletRequest request,
                             Model model) {
        String email = getCurrentStudentEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        String name = (user != null) ? user.getName() : email;

        QuizSubmission submission = quizService.evaluateSubmission(quizId, email, name, allParams, request.getRemoteAddr());
        Quiz quiz = quizService.getQuizById(quizId).orElse(null);

        model.addAttribute("submission", submission);
        model.addAttribute("quiz", quiz);
        model.addAttribute("userAnswers", allParams);
        return "student/quiz-result";
    }

    @GetMapping("/live")
    public String liveSessions(Model model) {
        List<LiveClass> upcoming = liveClassService.getUpcomingClasses();
        List<LiveClass> liveNow = liveClassService.getLiveNowClasses();
        model.addAttribute("upcoming", upcoming);
        model.addAttribute("liveNow", liveNow);
        return "student/live";
    }

    @GetMapping("/live/{id}/join")
    public String joinLiveSession(@PathVariable("id") Long id, Model model) {
        String email = getCurrentStudentEmail();
        UserMaster user = userService.getUserByEmail(email).orElse(null);
        LiveClass liveClass = liveClassService.getClassById(id)
                .orElseThrow(() -> new IllegalArgumentException("Live class session not found"));

        model.addAttribute("liveClass", liveClass);
        model.addAttribute("userName", (user != null) ? user.getName() : "Student");
        return "student/live-room";
    }

    @GetMapping("/analytics")
    public String studentAnalytics(Model model) {
        String email = getCurrentStudentEmail();
        List<Enrollment> enrollments = courseService.getStudentEnrollments(email);
        List<QuizSubmission> submissions = quizService.getSubmissionsByStudent(email);

        int totalCourses = enrollments.size();
        int completedCourses = (int) enrollments.stream().filter(e -> e.getProgressPct() >= 100).count();
        int totalQuizzesTaken = submissions.size();
        int passedQuizzes = (int) submissions.stream().filter(s -> "PASS".equalsIgnoreCase(s.getStatus())).count();

        model.addAttribute("enrollments", enrollments);
        model.addAttribute("submissions", submissions);
        model.addAttribute("totalCourses", totalCourses);
        model.addAttribute("completedCourses", completedCourses);
        model.addAttribute("totalQuizzesTaken", totalQuizzesTaken);
        model.addAttribute("passedQuizzes", passedQuizzes);

        return "student/analytics";
    }

    @GetMapping("/profile")
    public String studentProfile(Model model, HttpSession session,
                                 @RequestParam(value = "success", required = false) String success,
                                 @RequestParam(value = "pwdSuccess", required = false) String pwdSuccess,
                                 @RequestParam(value = "pwdError", required = false) String pwdError) {
        String email = getCurrentStudentEmail();
        if (email == null) {
            return "redirect:/login";
        }
        UserMaster student = userService.getUserByEmail(email).orElse(null);
        if (student == null) {
            return "redirect:/login";
        }

        session.setAttribute("userName", student.getName());
        session.setAttribute("email", email);
        session.setAttribute("regNumber", student.getRegistrationNumber());

        List<Enrollment> enrollments = courseService.getStudentEnrollments(email);
        List<Enrollment> completedCourses = enrollments.stream().filter(e -> e.getProgressPct() >= 100).toList();
        List<Enrollment> ongoingCourses = enrollments.stream().filter(e -> e.getProgressPct() < 100).toList();

        double avgProgress = enrollments.isEmpty() ? 0 : enrollments.stream().mapToDouble(Enrollment::getProgressPct).average().orElse(0);

        List<QuizSubmission> submissions = quizService.getSubmissionsByStudent(email);
        double avgScore = submissions.isEmpty() ? 0 : submissions.stream().mapToDouble(QuizSubmission::getScorePct).average().orElse(0);
        long passedQuizzes = submissions.stream().filter(s -> "PASS".equalsIgnoreCase(s.getStatus())).count();

        long totalCompletedLessons = lessonProgressRepository.countByStudentEmailAndCompletedTrue(email);
        int attendancePct = enrollments.isEmpty() ? 95 : Math.min(100, Math.max(78, (int) Math.round(avgProgress)));

        model.addAttribute("student", student);
        model.addAttribute("enrollments", enrollments);
        model.addAttribute("completedCourses", completedCourses);
        model.addAttribute("ongoingCourses", ongoingCourses);
        model.addAttribute("avgProgress", Math.round(avgProgress * 10.0) / 10.0);
        model.addAttribute("submissions", submissions);
        model.addAttribute("avgScore", Math.round(avgScore * 10.0) / 10.0);
        model.addAttribute("passedQuizzes", passedQuizzes);
        model.addAttribute("attendancePct", attendancePct);
        model.addAttribute("totalCompletedLessons", totalCompletedLessons);

        if (success != null) model.addAttribute("profileSuccess", "Your profile details have been successfully updated.");
        if (pwdSuccess != null) model.addAttribute("pwdSuccessMessage", "Your password has been changed successfully.");
        if (pwdError != null) model.addAttribute("pwdErrorMessage", pwdError);

        return "student/profile";
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
                                @RequestParam(value = "rollNumber", required = false) String rollNumber,
                                @RequestParam(value = "program", required = false) String program,
                                @RequestParam(value = "department", required = false) String department,
                                @RequestParam(value = "semester", required = false) String semester,
                                @RequestParam(value = "academicYear", required = false) String academicYear,
                                @RequestParam(value = "batch", required = false) String batch,
                                @RequestParam(value = "section", required = false) String section,
                                @RequestParam(value = "bio", required = false) String bio,
                                @RequestParam(value = "profilePhoto", required = false) String profilePhoto,
                                HttpServletRequest request) {
        String email = getCurrentStudentEmail();
        userService.updateStudentProfile(email, name, mobile, dob, gender, address, city, state, country,
                rollNumber, program, department, semester, academicYear, batch, section, bio, profilePhoto, request.getRemoteAddr());
        return "redirect:/student/profile?success=true";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpServletRequest request) {
        String email = getCurrentStudentEmail();
        if (!newPassword.equals(confirmPassword)) {
            return "redirect:/student/profile?pwdError=New+passwords+do+not+match.";
        }
        try {
            userService.changePassword(email, currentPassword, newPassword, request.getRemoteAddr());
            return "redirect:/student/profile?pwdSuccess=true";
        } catch (Exception e) {
            return "redirect:/student/profile?pwdError=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8);
        }
    }
}
