package com.example.lms.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_master")
public class UserMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role; // ROLE_ADMIN, ROLE_FACULTY, ROLE_STUDENT

    @Column
    private String name;

    @Column
    private String mobile;

    @Column(name = "registration_number", unique = true)
    private String registrationNumber; // e.g. STU-2026-001 or FAC-2026-001

    @Column
    private String status = "ACTIVE"; // ACTIVE, SUSPENDED, INACTIVE

    @Column(length = 1000)
    private String bio;

    @Column
    private String profilePhoto;

    @Column
    private String dob; // Date of Birth (YYYY-MM-DD)

    @Column
    private String gender; // Male, Female, Other

    @Column
    private String address;

    @Column
    private String city;

    @Column
    private String state;

    @Column
    private String country = "India";

    // --- Student Academic Details ---
    @Column
    private String rollNumber;

    @Column
    private String program; // e.g. "B.Tech CSE"

    @Column
    private String department; // e.g. "Computer Science & Engineering"

    @Column
    private String semester; // e.g. "6th Semester"

    @Column
    private String academicYear; // e.g. "3rd Year"

    @Column
    private String batch; // e.g. "2023 - 2027"

    @Column
    private String section; // e.g. "Section A"

    // --- Faculty Professional Details ---
    @Column
    private String designation; // Professor, Associate Professor, Assistant Professor, Lecturer

    @Column
    private String qualification; // e.g. "Ph.D. in Computer Science"

    @Column
    private String specialization; // e.g. "Cloud Computing, AI/ML"

    @Column
    private String experience; // e.g. "12+ Years"

    @Column
    private String joiningDate; // e.g. "2018-07-01"

    // --- Account / Session Tracking ---
    @Column
    private LocalDateTime lastLogin;

    @Column
    private LocalDateTime createdAt = LocalDateTime.now();

    public UserMaster() {}

    public UserMaster(String email, String password, String role, String name, String mobile, String registrationNumber) {
        this.email = email;
        this.password = password;
        this.role = role;
        this.name = name;
        this.mobile = mobile;
        this.registrationNumber = registrationNumber;
        this.status = "ACTIVE";
        this.country = "India";
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getMobile() {
        return mobile;
    }
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
    public String getRegistrationNumber() {
        return registrationNumber;
    }
    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getBio() {
        return bio;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }
    public String getProfilePhoto() {
        return profilePhoto;
    }
    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
    public String getDob() {
        return dob;
    }
    public void setDob(String dob) {
        this.dob = dob;
    }
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }
    public String getRollNumber() {
        return rollNumber;
    }
    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }
    public String getProgram() {
        return program;
    }
    public void setProgram(String program) {
        this.program = program;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    public String getSemester() {
        return semester;
    }
    public void setSemester(String semester) {
        this.semester = semester;
    }
    public String getAcademicYear() {
        return academicYear;
    }
    public void setAcademicYear(String academicYear) {
        this.academicYear = academicYear;
    }
    public String getBatch() {
        return batch;
    }
    public void setBatch(String batch) {
        this.batch = batch;
    }
    public String getSection() {
        return section;
    }
    public void setSection(String section) {
        this.section = section;
    }
    public String getDesignation() {
        return designation;
    }
    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public String getQualification() {
        return qualification;
    }
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
    public String getSpecialization() {
        return specialization;
    }
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    public String getExperience() {
        return experience;
    }
    public void setExperience(String experience) {
        this.experience = experience;
    }
    public String getJoiningDate() {
        return joiningDate;
    }
    public void setJoiningDate(String joiningDate) {
        this.joiningDate = joiningDate;
    }
    public LocalDateTime getLastLogin() {
        return lastLogin;
    }
    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
