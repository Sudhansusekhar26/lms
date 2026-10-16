package com.example.lms.repository;

import com.example.lms.model.UserMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserMaster, Long> {
    Optional<UserMaster> findByEmail(String email);
    boolean existsByEmail(String email);
    List<UserMaster> findByRole(String role);
    long countByRole(String role);
    long countByStatus(String status);
}
