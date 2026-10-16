package com.example.lms.repository;

import com.example.lms.model.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {
    List<Enrollment> findByStudentEmailOrderByEnrolledAtDesc(String studentEmail);
    Optional<Enrollment> findByStudentEmailAndCourseId(String studentEmail, Long courseId);
    boolean existsByStudentEmailAndCourseId(String studentEmail, Long courseId);
    long countByCourseId(Long courseId);
    long countByStudentEmail(String studentEmail);
    List<Enrollment> findByCourseInstructorEmail(String instructorEmail);
    List<Enrollment> findByCourseId(Long courseId);
}
