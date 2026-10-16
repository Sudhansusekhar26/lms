package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "live_classes")
public class LiveClass {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    @Column(nullable = false)
    private String instructorEmail;

    @Column(nullable = false)
    private String title;

    @Column(length = 1000)
    private String description;

    @Column(nullable = false)
    private LocalDateTime scheduledAt;

    @Column
    private int durationMinutes = 60;

    @Column(nullable = false)
    private String roomId; // e.g. Jitsi / WebRTC room identifier

    @Column
    private String status = "UPCOMING"; // UPCOMING, LIVE, COMPLETED, CANCELLED

    @Column(length = 1000)
    private String meetingUrl;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    public LiveClass() {}

    public LiveClass(Course course, String instructorEmail, String title, String description, LocalDateTime scheduledAt, int durationMinutes, String roomId) {
        this.course = course;
        this.instructorEmail = instructorEmail;
        this.title = title;
        this.description = description;
        this.scheduledAt = scheduledAt;
        this.durationMinutes = durationMinutes;
        this.roomId = roomId;
        this.status = "UPCOMING";
        this.meetingUrl = "https://meet.jit.si/LMS_Live_" + roomId;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    public String getInstructorEmail() { return instructorEmail; }
    public void setInstructorEmail(String instructorEmail) { this.instructorEmail = instructorEmail; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDateTime getScheduledAt() { return scheduledAt; }
    public void setScheduledAt(LocalDateTime scheduledAt) { this.scheduledAt = scheduledAt; }
    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }
    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getMeetingUrl() { return meetingUrl; }
    public void setMeetingUrl(String meetingUrl) { this.meetingUrl = meetingUrl; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
