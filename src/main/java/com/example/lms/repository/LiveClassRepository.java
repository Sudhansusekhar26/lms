package com.example.lms.repository;

import com.example.lms.model.LiveClass;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LiveClassRepository extends JpaRepository<LiveClass, Long> {
    List<LiveClass> findByCourseIdOrderByScheduledAtAsc(Long courseId);
    List<LiveClass> findByInstructorEmailOrderByScheduledAtDesc(String instructorEmail);
    List<LiveClass> findByStatusOrderByScheduledAtAsc(String status);
    Optional<LiveClass> findByRoomId(String roomId);
    List<LiveClass> findTop5ByStatusOrderByScheduledAtAsc(String status);
}
