package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quiz_submissions")
public class QuizSubmission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "quiz_id", nullable = false)
    private Quiz quiz;

    @Column(nullable = false)
    private String studentEmail;

    @Column
    private String studentName;

    @Column
    private int totalQuestions;

    @Column
    private int correctAnswers;

    @Column
    private int wrongAnswers;

    @Column
    private double scorePct;

    @Column
    private String status; // PASS, FAIL

    @Column
    private LocalDateTime submittedAt = LocalDateTime.now();

    public QuizSubmission() {}

    public QuizSubmission(Quiz quiz, String studentEmail, String studentName, int totalQuestions, int correctAnswers, int wrongAnswers, double scorePct, String status) {
        this.quiz = quiz;
        this.studentEmail = studentEmail;
        this.studentName = studentName;
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
        this.wrongAnswers = wrongAnswers;
        this.scorePct = scorePct;
        this.status = status;
        this.submittedAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Quiz getQuiz() { return quiz; }
    public void setQuiz(Quiz quiz) { this.quiz = quiz; }
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
    public int getCorrectAnswers() { return correctAnswers; }
    public void setCorrectAnswers(int correctAnswers) { this.correctAnswers = correctAnswers; }
    public int getWrongAnswers() { return wrongAnswers; }
    public void setWrongAnswers(int wrongAnswers) { this.wrongAnswers = wrongAnswers; }
    public double getScorePct() { return scorePct; }
    public void setScorePct(double scorePct) { this.scorePct = scorePct; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(LocalDateTime submittedAt) { this.submittedAt = submittedAt; }

    public int getScore() { return correctAnswers; }
    public int getTotalPoints() { return totalQuestions; }
}
