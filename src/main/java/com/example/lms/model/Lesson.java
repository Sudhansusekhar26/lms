package com.example.lms.model;

import jakarta.persistence.*;

@Entity
@Table(name = "course_lessons")
public class Lesson {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "section_id", nullable = false)
    private Section section;

    @Column(nullable = false)
    private String title;

    @Column
    private int orderNum = 1;

    @Column(length = 1000)
    private String videoUrl;

    @Column(length = 5000)
    private String contentText;

    @Column(length = 1000)
    private String materialUrl; // S3 / Cloud / PDF URL

    @Column
    private String materialName;

    @Column
    private int durationMinutes = 15;

    public Lesson() {}

    public Lesson(Section section, String title, int orderNum, String videoUrl, String contentText, String materialUrl, String materialName, int durationMinutes) {
        this.section = section;
        this.title = title;
        this.orderNum = orderNum;
        this.videoUrl = videoUrl;
        this.contentText = contentText;
        this.materialUrl = materialUrl;
        this.materialName = materialName;
        this.durationMinutes = durationMinutes;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Section getSection() { return section; }
    public void setSection(Section section) { this.section = section; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public int getOrderNum() { return orderNum; }
    public void setOrderNum(int orderNum) { this.orderNum = orderNum; }
    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }
    public String getContentText() { return contentText; }
    public void setContentText(String contentText) { this.contentText = contentText; }
    public String getMaterialUrl() { return materialUrl; }
    public void setMaterialUrl(String materialUrl) { this.materialUrl = materialUrl; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String materialName) { this.materialName = materialName; }
    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }
}
