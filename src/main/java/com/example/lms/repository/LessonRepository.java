package com.example.lms.repository;

import com.example.lms.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findBySectionIdOrderByOrderNumAsc(Long sectionId);
    List<Lesson> findBySectionCourseIdOrderByOrderNumAsc(Long courseId);
    long countBySectionCourseId(Long courseId);
}
