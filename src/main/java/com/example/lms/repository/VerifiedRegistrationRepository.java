package com.example.lms.repository;

import com.example.lms.model.VerifiedRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VerifiedRegistrationRepository extends JpaRepository<VerifiedRegistration, Long> {
    Optional<VerifiedRegistration> findByRegistrationNumberIgnoreCase(String registrationNumber);
    Optional<VerifiedRegistration> findByRegistrationNumberIgnoreCaseAndRole(String registrationNumber, String role);
    boolean existsByRegistrationNumberIgnoreCase(String registrationNumber);
    List<VerifiedRegistration> findByRoleOrderByCreatedAtDesc(String role);
    List<VerifiedRegistration> findAllByOrderByCreatedAtDesc();
}
