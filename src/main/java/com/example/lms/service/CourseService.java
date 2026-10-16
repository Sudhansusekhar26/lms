package com.example.lms.service;

import com.example.lms.model.*;
import com.example.lms.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class CourseService {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SectionRepository sectionRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Autowired
    private LessonProgressRepository lessonProgressRepository;

    @Autowired
    private AuditLogService auditLogService;

    public List<Course> getAllPublishedCourses() {
        return courseRepository.findByPublishedTrue();
    }

    public List<Course> searchCourses(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllPublishedCourses();
        }
        return courseRepository.findByPublishedTrueAndTitleContainingIgnoreCase(keyword);
    }

    public Optional<Course> getCourseById(Long id) {
        return courseRepository.findById(id);
    }

    public List<Course> getCoursesByInstructor(String instructorEmail) {
        return courseRepository.findByInstructorEmail(instructorEmail);
    }

    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    public Course createCourse(String title, String description, String level, String duration, String price, String thumbnailUrl, Long categoryId, String instructorEmail, String instructorName, String ip) {
        Category category = null;
        if (categoryId != null) {
            category = categoryRepository.findById(categoryId).orElse(null);
        }
        Course course = new Course(title, description, level, duration, price, thumbnailUrl, instructorEmail, instructorName, category);
        Course saved = courseRepository.save(course);
        auditLogService.log(instructorEmail, "COURSE_CREATED", "Created course: " + title + " (ID: " + saved.getId() + ")", ip);
        return saved;
    }

    public Course createCourse(String title, String description, String level, String thumbnailUrl, Long categoryId, String instructorEmail, String instructorName, String ip) {
        return createCourse(title, description, level, "8 Weeks", "Free", thumbnailUrl, categoryId, instructorEmail, instructorName, ip);
    }

    public Course updateCourse(Long courseId, String title, String description, String level, String duration, String price, String thumbnailUrl, Long categoryId, boolean isPublished, String instructorEmail, String ip) {
        Optional<Course> opt = courseRepository.findById(courseId);
        if (opt.isPresent()) {
            Course course = opt.get();
            course.setTitle(title);
            course.setDescription(description);
            course.setLevel(level);
            if (duration != null && !duration.trim().isEmpty()) {
                course.setDuration(duration);
            }
            if (price != null && !price.trim().isEmpty()) {
                course.setPrice(price);
            }
            if (thumbnailUrl != null && !thumbnailUrl.trim().isEmpty()) {
                course.setThumbnailUrl(thumbnailUrl);
            }
            if (categoryId != null) {
                categoryRepository.findById(categoryId).ifPresent(course::setCategory);
            }
            course.setPublished(isPublished);
            Course saved = courseRepository.save(course);
            auditLogService.log(instructorEmail, "COURSE_UPDATED", "Updated course: " + title, ip);
            return saved;
        }
        return null;
    }

    public Course updateCourse(Long courseId, String title, String description, String level, String thumbnailUrl, Long categoryId, boolean isPublished, String instructorEmail, String ip) {
        return updateCourse(courseId, title, description, level, "8 Weeks", "Free", thumbnailUrl, categoryId, isPublished, instructorEmail, ip);
    }

    public void deleteCourse(Long courseId, String instructorEmail, String ip) {
        courseRepository.findById(courseId).ifPresent(course -> {
            courseRepository.delete(course);
            auditLogService.log(instructorEmail, "COURSE_DELETED", "Deleted course ID: " + courseId, ip);
        });
    }

    public Section addSection(Long courseId, String title, int orderNum) {
        Course course = courseRepository.findById(courseId).orElseThrow(() -> new IllegalArgumentException("Course not found"));
        Section section = new Section(course, title, orderNum);
        return sectionRepository.save(section);
    }

    public Lesson addLesson(Long sectionId, String title, int orderNum, String videoUrl, String contentText, String materialUrl, String materialName, int durationMinutes) {
        Section section = sectionRepository.findById(sectionId).orElseThrow(() -> new IllegalArgumentException("Section not found"));
        Lesson lesson = new Lesson(section, title, orderNum, videoUrl, contentText, materialUrl, materialName, durationMinutes);
        return lessonRepository.save(lesson);
    }

    @Transactional
    public Enrollment enrollStudent(String studentEmail, Long courseId, String ip) {
        Course course = courseRepository.findById(courseId).orElseThrow(() -> new IllegalArgumentException("Course not found"));
        if (course.isUpcoming()) {
            throw new IllegalStateException("Enrollment for this course is not yet open. It is scheduled as an upcoming program.");
        }
        Optional<Enrollment> existing = enrollmentRepository.findByStudentEmailAndCourseId(studentEmail, courseId);
        if (existing.isPresent()) {
            return existing.get();
        }

        Enrollment enrollment = new Enrollment(studentEmail, course);
        Enrollment saved = enrollmentRepository.save(enrollment);
        auditLogService.log(studentEmail, "COURSE_ENROLLED", "Enrolled in course: " + course.getTitle(), ip);
        return saved;
    }

    public boolean isStudentEnrolled(String studentEmail, Long courseId) {
        return enrollmentRepository.existsByStudentEmailAndCourseId(studentEmail, courseId);
    }

    public List<Enrollment> getStudentEnrollments(String studentEmail) {
        return enrollmentRepository.findByStudentEmailOrderByEnrolledAtDesc(studentEmail);
    }

    public List<Enrollment> getInstructorEnrollments(String instructorEmail) {
        return enrollmentRepository.findByCourseInstructorEmail(instructorEmail);
    }

    @Transactional
    public void markLessonComplete(String studentEmail, Long lessonId, Long courseId) {
        Optional<LessonProgress> opt = lessonProgressRepository.findByStudentEmailAndLessonId(studentEmail, lessonId);
        if (opt.isPresent()) {
            LessonProgress lp = opt.get();
            lp.setCompleted(true);
            lp.setCompletedAt(LocalDateTime.now());
            lessonProgressRepository.save(lp);
        } else {
            LessonProgress lp = new LessonProgress(studentEmail, lessonId, courseId, true);
            lessonProgressRepository.save(lp);
        }

        updateEnrollmentProgress(studentEmail, courseId);
    }

    @Transactional
    public void updateEnrollmentProgress(String studentEmail, Long courseId) {
        Course course = courseRepository.findById(courseId).orElse(null);
        if (course == null) return;

        int totalLessons = course.getTotalLessons();
        if (totalLessons == 0) return;

        long completed = lessonProgressRepository.countByStudentEmailAndCourseIdAndCompletedTrue(studentEmail, courseId);
        int progressPct = (int) Math.min(100, Math.round(((double) completed / totalLessons) * 100));

        enrollmentRepository.findByStudentEmailAndCourseId(studentEmail, courseId).ifPresent(enrollment -> {
            enrollment.setProgressPct(progressPct);
            if (progressPct >= 100 && enrollment.getCompletedAt() == null) {
                enrollment.setCompletedAt(LocalDateTime.now());
            }
            enrollmentRepository.save(enrollment);
        });
    }

    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    public Category createCategory(String name, String description, String icon) {
        Category cat = new Category(name, description, icon);
        return categoryRepository.save(cat);
    }

    public void assignFacultyToCourse(Long courseId, String facultyEmail, String facultyName, String adminEmail, String ip) {
        courseRepository.findById(courseId).ifPresent(c -> {
            c.setInstructorEmail(facultyEmail);
            c.setInstructorName(facultyName);
            courseRepository.save(c);
            auditLogService.log(adminEmail, "COURSE_FACULTY_ASSIGNED", "Assigned course " + c.getTitle() + " to " + facultyName + " (" + facultyEmail + ")", ip);
        });
    }

    public List<Lesson> getAllLessonsWithMaterials() {
        return lessonRepository.findAll().stream()
                .filter(l -> (l.getMaterialUrl() != null && !l.getMaterialUrl().trim().isEmpty())
                        || (l.getVideoUrl() != null && !l.getVideoUrl().trim().isEmpty())
                        || (l.getContentText() != null && !l.getContentText().trim().isEmpty()))
                .toList();
    }

    public void updateLessonMaterial(Long lessonId, String materialUrl, String materialName, String adminEmail, String ip) {
        lessonRepository.findById(lessonId).ifPresent(l -> {
            l.setMaterialUrl(materialUrl);
            l.setMaterialName(materialName);
            lessonRepository.save(l);
            auditLogService.log(adminEmail, "LESSON_MATERIAL_UPDATED", "Updated material for lesson: " + l.getTitle(), ip);
        });
    }

    public void deleteLesson(Long lessonId, String adminEmail, String ip) {
        lessonRepository.findById(lessonId).ifPresent(l -> {
            lessonRepository.delete(l);
            auditLogService.log(adminEmail, "LESSON_DELETED", "Deleted lesson: " + l.getTitle(), ip);
        });
    }

    public long countTotalCourses() { return courseRepository.count(); }
    public long countPublishedCourses() { return courseRepository.countByPublishedTrue(); }
    public long countTotalEnrollments() { return enrollmentRepository.count(); }
}
