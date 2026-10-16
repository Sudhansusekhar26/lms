package com.example.lms.service;

import com.example.lms.model.Course;
import com.example.lms.model.LiveClass;
import com.example.lms.repository.CourseRepository;
import com.example.lms.repository.LiveClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class LiveClassService {

    @Autowired
    private LiveClassRepository liveClassRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private AuditLogService auditLogService;

    public LiveClass scheduleClass(Long courseId, String instructorEmail, String title, String description, LocalDateTime scheduledAt, int durationMinutes, String ip) {
        Course course = courseRepository.findById(courseId).orElseThrow(() -> new IllegalArgumentException("Course not found"));
        String roomId = "LMS-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        LiveClass liveClass = new LiveClass(course, instructorEmail, title, description, scheduledAt, durationMinutes, roomId);
        LiveClass saved = liveClassRepository.save(liveClass);
        auditLogService.log(instructorEmail, "LIVE_CLASS_SCHEDULED", "Scheduled live class: " + title + " (Room: " + roomId + ")", ip);
        return saved;
    }

    public List<LiveClass> getUpcomingClasses() {
        return liveClassRepository.findByStatusOrderByScheduledAtAsc("UPCOMING");
    }

    public List<LiveClass> getLiveNowClasses() {
        return liveClassRepository.findByStatusOrderByScheduledAtAsc("LIVE");
    }

    public List<LiveClass> getAllClasses() {
        return liveClassRepository.findAll();
    }

    public List<LiveClass> getClassesByInstructor(String instructorEmail) {
        return liveClassRepository.findByInstructorEmailOrderByScheduledAtDesc(instructorEmail);
    }

    public List<LiveClass> getClassesByCourse(Long courseId) {
        return liveClassRepository.findByCourseIdOrderByScheduledAtAsc(courseId);
    }

    public Optional<LiveClass> getClassById(Long id) {
        return liveClassRepository.findById(id);
    }

    public Optional<LiveClass> getClassByRoomId(String roomId) {
        return liveClassRepository.findByRoomId(roomId);
    }

    public void updateStatus(Long classId, String newStatus, String actorEmail, String ip) {
        liveClassRepository.findById(classId).ifPresent(lc -> {
            lc.setStatus(newStatus);
            liveClassRepository.save(lc);
            auditLogService.log(actorEmail, "LIVE_CLASS_STATUS", "Updated live class " + lc.getTitle() + " status to " + newStatus, ip);
        });
    }

    public long countTotalClasses() { return liveClassRepository.count(); }
}
