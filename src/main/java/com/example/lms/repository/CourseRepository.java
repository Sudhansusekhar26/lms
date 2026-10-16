package com.example.lms.repository;

import com.example.lms.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByPublishedTrue();
    List<Course> findByInstructorEmail(String instructorEmail);
    List<Course> findByCategoryId(Long categoryId);
    List<Course> findByPublishedTrueAndTitleContainingIgnoreCase(String keyword);
    long countByInstructorEmail(String instructorEmail);
    long countByPublishedTrue();
    java.util.Optional<Course> findByTitle(String title);
    boolean existsByTitle(String title);
}
