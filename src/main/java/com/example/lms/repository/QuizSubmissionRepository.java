package com.example.lms.repository;

import com.example.lms.model.QuizSubmission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuizSubmissionRepository extends JpaRepository<QuizSubmission, Long> {
    List<QuizSubmission> findByStudentEmailOrderBySubmittedAtDesc(String studentEmail);
    List<QuizSubmission> findByQuizIdOrderBySubmittedAtDesc(Long quizId);
    List<QuizSubmission> findByQuizCourseInstructorEmailOrderBySubmittedAtDesc(String instructorEmail);
    List<QuizSubmission> findAllByOrderBySubmittedAtDesc();
    long countByStudentEmail(String studentEmail);
}
