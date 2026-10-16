package com.example.lms.repository;

import com.example.lms.model.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuizRepository extends JpaRepository<Quiz, Long> {
    List<Quiz> findByCourseId(Long courseId);
    List<Quiz> findByCourseInstructorEmail(String instructorEmail);
    List<Quiz> findByPublishedTrue();
}
