package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "verified_registrations")
public class VerifiedRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "registration_number", nullable = false, unique = true)
    private String registrationNumber; // e.g. STU-2026-001, FAC-2026-001

    @Column(nullable = false)
    private String role; // ROLE_STUDENT, ROLE_FACULTY

    @Column
    private String allocatedName; // Optional expected name or notes

    @Column
    private String department; // e.g. Computer Science, Cloud Systems

    @Column(name = "is_used")
    private boolean used = false;

    @Column
    private String usedByEmail;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    public VerifiedRegistration() {}

    public VerifiedRegistration(String registrationNumber, String role, String allocatedName, String department) {
        this.registrationNumber = registrationNumber.trim().toUpperCase();
        this.role = role.toUpperCase().startsWith("ROLE_") ? role.toUpperCase() : "ROLE_" + role.toUpperCase();
        this.allocatedName = allocatedName;
        this.department = department;
        this.used = false;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getRegistrationNumber() { return registrationNumber; }
    public void setRegistrationNumber(String registrationNumber) { this.registrationNumber = registrationNumber; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getAllocatedName() { return allocatedName; }
    public void setAllocatedName(String allocatedName) { this.allocatedName = allocatedName; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public boolean isUsed() { return used; }
    public void setUsed(boolean used) { this.used = used; }
    public String getUsedByEmail() { return usedByEmail; }
    public void setUsedByEmail(String usedByEmail) { this.usedByEmail = usedByEmail; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
