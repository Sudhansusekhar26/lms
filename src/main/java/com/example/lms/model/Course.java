package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(length = 3000)
    private String description;

    @Column
    private String level = "Beginner"; // Beginner, Intermediate, Advanced

    @Column
    private String duration = "8 Weeks"; // e.g. 8 Weeks, 10 Weeks, 16 Weeks

    @Column
    private String price = "Free"; // e.g. Free, $49, etc.

    @Column
    private String thumbnailUrl = "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&auto=format&fit=crop&q=60";

    @Column
    private boolean published = true;

    @Column(nullable = false)
    private String instructorEmail;

    @Column
    private String instructorName;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    private Category category;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @OrderBy("orderNum ASC")
    private List<Section> sections = new ArrayList<>();

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<LiveClass> liveClasses = new ArrayList<>();

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Quiz> quizzes = new ArrayList<>();

    public Course() {}

    public Course(String title, String description, String level, String duration, String price, String thumbnailUrl, String instructorEmail, String instructorName, Category category) {
        this.title = title;
        this.description = description;
        this.level = level;
        this.duration = (duration != null && !duration.trim().isEmpty()) ? duration : "8 Weeks";
        this.price = (price != null && !price.trim().isEmpty()) ? price : "Free";
        if (thumbnailUrl != null && !thumbnailUrl.trim().isEmpty()) {
            this.thumbnailUrl = thumbnailUrl;
        }
        this.instructorEmail = instructorEmail;
        this.instructorName = instructorName;
        this.category = category;
        this.published = true;
        this.createdAt = LocalDateTime.now();
    }

    public Course(String title, String description, String level, String thumbnailUrl, String instructorEmail, String instructorName, Category category) {
        this(title, description, level, "8 Weeks", "Free", thumbnailUrl, instructorEmail, instructorName, category);
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
    public String getPrice() { return price; }
    public void setPrice(String price) { this.price = price; }
    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }
    @Column(name = "upcoming")
    private Boolean upcoming = Boolean.FALSE;

    public boolean isUpcoming() { return upcoming != null && upcoming; }
    public void setUpcoming(Boolean upcoming) { this.upcoming = (upcoming != null) ? upcoming : Boolean.FALSE; }

    public boolean isPublished() { return published; }
    public void setPublished(boolean published) { this.published = published; }
    public String getInstructorEmail() { return instructorEmail; }
    public void setInstructorEmail(String instructorEmail) { this.instructorEmail = instructorEmail; }
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public List<Section> getSections() { return sections; }
    public void setSections(List<Section> sections) { this.sections = sections; }
    public List<LiveClass> getLiveClasses() { return liveClasses; }
    public void setLiveClasses(List<LiveClass> liveClasses) { this.liveClasses = liveClasses; }
    public List<Quiz> getQuizzes() { return quizzes; }
    public void setQuizzes(List<Quiz> quizzes) { this.quizzes = quizzes; }

    public int getTotalLessons() {
        if (sections == null) return 0;
        int count = 0;
        for (Section s : sections) {
            if (s.getLessons() != null) {
                count += s.getLessons().size();
            }
        }
        return count;
    }
}
