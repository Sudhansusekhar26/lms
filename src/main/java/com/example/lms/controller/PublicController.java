package com.example.lms.controller;

import com.example.lms.model.Announcement;
import com.example.lms.model.ContactMessage;
import com.example.lms.model.Course;
import com.example.lms.model.Enrollment;
import com.example.lms.model.UserMaster;
import com.example.lms.repository.AnnouncementRepository;
import com.example.lms.repository.ContactMessageRepository;
import com.example.lms.repository.EnrollmentRepository;
import com.example.lms.repository.UserRepository;
import com.example.lms.service.CourseService;
import com.example.lms.service.LiveClassService;
import com.example.lms.service.QuizService;
import com.example.lms.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class PublicController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private CourseService courseService;

    @Autowired
    private UserService userService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private LiveClassService liveClassService;

    @Autowired
    private AnnouncementRepository announcementRepository;

    @Autowired
    private ContactMessageRepository contactMessageRepository;

    @GetMapping({"/", "/index"})
    public String index(@RequestParam(value = "contactSent", required = false) String contactSent, Model model) {
        List<Course> featuredCourses = courseService.getAllPublishedCourses();
        model.addAttribute("courses", featuredCourses);
        model.addAttribute("categories", courseService.getAllCategories());
        model.addAttribute("announcements", announcementRepository.findAllByOrderByCreatedAtDesc());
        model.addAttribute("totalCourses", courseService.countTotalCourses());
        model.addAttribute("totalStudents", userService.countByRole("ROLE_STUDENT"));
        model.addAttribute("totalFaculty", userService.countByRole("ROLE_FACULTY"));
        model.addAttribute("upcomingLive", liveClassService.getUpcomingClasses());
        Course upcomingCourse = featuredCourses.stream().filter(Course::isUpcoming).findFirst().orElse(null);
        if (upcomingCourse == null) {
            upcomingCourse = featuredCourses.stream().filter(c -> c.getTitle() != null && c.getTitle().toLowerCase().contains("full stack")).findFirst().orElse(null);
            if (upcomingCourse != null) {
                upcomingCourse.setUpcoming(true);
            }
        }
        model.addAttribute("upcomingCourse", upcomingCourse);
        if ("true".equalsIgnoreCase(contactSent)) {
            model.addAttribute("contactSuccess", "Thank you! Your message has been received. Our academic admissions team will get back to you shortly.");
        }
        return "index";
    }

    @GetMapping("/catalog")
    public String catalog(@RequestParam(value = "search", required = false) String search,
                          @RequestParam(value = "categoryId", required = false) Long categoryId,
                          Model model) {
        List<Course> courses;
        if (search != null && !search.trim().isEmpty()) {
            courses = courseService.searchCourses(search);
        } else {
            courses = courseService.getAllPublishedCourses();
        }

        model.addAttribute("courses", courses);
        model.addAttribute("categories", courseService.getAllCategories());
        model.addAttribute("searchTerm", search);
        model.addAttribute("selectedCategoryId", categoryId);
        return "catalog";
    }

    @GetMapping("/courses/{id}")
    public String courseDetails(@PathVariable("id") Long id, Model model) {
        Course course = courseService.getCourseById(id)
                .orElseThrow(() -> new IllegalArgumentException("Course not found"));
        model.addAttribute("course", course);
        return "course-details";
    }

    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("totalCourses", courseService.countTotalCourses());
        model.addAttribute("totalStudents", userService.countByRole("ROLE_STUDENT"));
        model.addAttribute("totalFaculty", userService.countByRole("ROLE_FACULTY"));
        return "about";
    }

    @GetMapping({"/service", "/services"})
    public String service() {
        return "service";
    }

    @GetMapping("/contact")
    public String contact(Model model) {
        return "contact";
    }

    @PostMapping("/contact")
    public String saveContact(@RequestParam("name") String name,
                              @RequestParam("email") String email,
                              @RequestParam("mobile") String mobile,
                              @RequestParam("message") String message,
                              @RequestParam(value = "source", required = false) String source,
                              Model model) {
        ContactMessage msg = new ContactMessage(name, email, mobile, message);
        contactMessageRepository.save(msg);
        if ("home".equalsIgnoreCase(source)) {
            return "redirect:/?contactSent=true#contact";
        }
        model.addAttribute("con", "success");
        model.addAttribute("successMsg", "Thank you! Your message has been received. Our academic team will get back to you shortly.");
        return "contact";
    }

    @GetMapping("/verify-certificate")
    public String verifyCertificate(@RequestParam(value = "certId", required = false) String certId, Model model) {
        if (certId != null && !certId.trim().isEmpty()) {
            return "redirect:/certificate/" + certId.trim().toUpperCase();
        }
        return "verify-certificate";
    }

    @GetMapping("/certificate/{certId}")
    public String viewCertificate(@PathVariable("certId") String certId, Model model) {
        model.addAttribute("certId", certId);
        try {
            if (certId != null && certId.toUpperCase().startsWith("CERT-STU-")) {
                String[] parts = certId.toUpperCase().split("-");
                if (parts.length >= 4) {
                    Long courseId = Long.parseLong(parts[2]);
                    Long studentId = Long.parseLong(parts[3]);
                    Course course = courseService.getCourseById(courseId).orElse(null);
                    UserMaster student = userRepository.findById(studentId).orElse(null);
                    if (course != null && student != null) {
                        Enrollment enrollment = enrollmentRepository.findByStudentEmailAndCourseId(student.getEmail(), courseId).orElse(null);
                        boolean isCompleted = (enrollment != null && enrollment.getProgressPct() >= 100);
                        model.addAttribute("course", course);
                        model.addAttribute("student", student);
                        model.addAttribute("enrollment", enrollment);
                        model.addAttribute("isVerified", isCompleted);
                        model.addAttribute("valid", true);
                        return "certificate";
                    }
                }
            }
        } catch (Exception ignored) {}
        model.addAttribute("valid", false);
        model.addAttribute("isVerified", false);
        return "certificate";
    }
}
