package com.example.lms.service;

import com.example.lms.model.UserMaster;
import com.example.lms.model.VerifiedRegistration;
import com.example.lms.repository.UserRepository;
import com.example.lms.repository.VerifiedRegistrationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VerifiedRegistrationRepository verifiedRegistrationRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuditLogService auditLogService;

    @Transactional
    public UserMaster registerUser(String name, String email, String mobile, String rawPassword, String role, String registrationNumber, String ip) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("An account with email " + email + " already exists.");
        }

        String formattedRole = role.toUpperCase();
        if (!formattedRole.startsWith("ROLE_")) {
            formattedRole = "ROLE_" + formattedRole;
        }

        String cleanRegNum = (registrationNumber != null) ? registrationNumber.trim().toUpperCase() : "";

        // Registration Number Pre-Check for Students and Faculty
        if ("ROLE_STUDENT".equals(formattedRole) || "ROLE_FACULTY".equals(formattedRole)) {
            if (cleanRegNum.isEmpty()) {
                throw new IllegalArgumentException("Registration Number is required for " + ("ROLE_STUDENT".equals(formattedRole) ? "Student" : "Faculty") + " registration.");
            }

            Optional<VerifiedRegistration> verifiedOpt = verifiedRegistrationRepository.findByRegistrationNumberIgnoreCaseAndRole(cleanRegNum, formattedRole);
            if (verifiedOpt.isEmpty()) {
                throw new IllegalArgumentException("Invalid Registration Number (" + cleanRegNum + ") for " + ("ROLE_STUDENT".equals(formattedRole) ? "Student" : "Faculty") + ". It does not match the institute database.");
            }

            VerifiedRegistration verified = verifiedOpt.get();
            if (verified.isUsed()) {
                throw new IllegalArgumentException("Registration Number " + cleanRegNum + " is already in use by account: " + verified.getUsedByEmail());
            }

            // Mark registration number as claimed
            verified.setUsed(true);
            verified.setUsedByEmail(email);
            verifiedRegistrationRepository.save(verified);
        }

        UserMaster user = new UserMaster(email, passwordEncoder.encode(rawPassword), formattedRole, name, mobile, cleanRegNum);
        user.setStatus("ACTIVE");
        UserMaster saved = userRepository.save(user);

        auditLogService.log(email, "USER_REGISTERED", "Registered with role " + formattedRole + " | Reg No: " + cleanRegNum, ip);
        return saved;
    }

    @Transactional
    public UserMaster updateStudentProfile(String email, String name, String mobile, String dob, String gender,
                                         String address, String city, String state, String country,
                                         String rollNumber, String program, String department, String semester,
                                         String academicYear, String batch, String section, String bio,
                                         String profilePhoto, String ip) {
        UserMaster user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + email));

        if (name != null && !name.trim().isEmpty()) user.setName(name.trim());
        if (mobile != null) user.setMobile(mobile.trim());
        if (dob != null) user.setDob(dob.trim());
        if (gender != null) user.setGender(gender.trim());
        if (address != null) user.setAddress(address.trim());
        if (city != null) user.setCity(city.trim());
        if (state != null) user.setState(state.trim());
        if (country != null) user.setCountry(country.trim());

        if (rollNumber != null) user.setRollNumber(rollNumber.trim());
        if (program != null) user.setProgram(program.trim());
        if (department != null) user.setDepartment(department.trim());
        if (semester != null) user.setSemester(semester.trim());
        if (academicYear != null) user.setAcademicYear(academicYear.trim());
        if (batch != null) user.setBatch(batch.trim());
        if (section != null) user.setSection(section.trim());

        if (bio != null) user.setBio(bio.trim());
        if (profilePhoto != null && !profilePhoto.trim().isEmpty()) user.setProfilePhoto(profilePhoto.trim());

        UserMaster saved = userRepository.save(user);
        auditLogService.log(email, "STUDENT_PROFILE_UPDATED", "Student updated profile details", ip);
        return saved;
    }

    @Transactional
    public UserMaster updateFacultyProfile(String email, String name, String mobile, String dob, String gender,
                                         String address, String city, String state, String country,
                                         String department, String designation, String qualification,
                                         String specialization, String experience, String joiningDate,
                                         String bio, String profilePhoto, String ip) {
        UserMaster user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + email));

        if (name != null && !name.trim().isEmpty()) user.setName(name.trim());
        if (mobile != null) user.setMobile(mobile.trim());
        if (dob != null) user.setDob(dob.trim());
        if (gender != null) user.setGender(gender.trim());
        if (address != null) user.setAddress(address.trim());
        if (city != null) user.setCity(city.trim());
        if (state != null) user.setState(state.trim());
        if (country != null) user.setCountry(country.trim());

        if (department != null) user.setDepartment(department.trim());
        if (designation != null) user.setDesignation(designation.trim());
        if (qualification != null) user.setQualification(qualification.trim());
        if (specialization != null) user.setSpecialization(specialization.trim());
        if (experience != null) user.setExperience(experience.trim());
        if (joiningDate != null) user.setJoiningDate(joiningDate.trim());

        if (bio != null) user.setBio(bio.trim());
        if (profilePhoto != null && !profilePhoto.trim().isEmpty()) user.setProfilePhoto(profilePhoto.trim());

        UserMaster saved = userRepository.save(user);
        auditLogService.log(email, "FACULTY_PROFILE_UPDATED", "Faculty updated profile details", ip);
        return saved;
    }

    @Transactional
    public UserMaster updateAdminProfile(String email, String name, String mobile, String address, String city, String state, String country, String department, String designation, String bio, String profilePhoto, String ip) {
        UserMaster user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Admin user not found: " + email));

        if (name != null && !name.trim().isEmpty()) user.setName(name.trim());
        if (mobile != null) user.setMobile(mobile.trim());
        if (address != null) user.setAddress(address.trim());
        if (city != null) user.setCity(city.trim());
        if (state != null) user.setState(state.trim());
        if (country != null) user.setCountry(country.trim());
        if (department != null) user.setDepartment(department.trim());
        if (designation != null) user.setDesignation(designation.trim());
        if (bio != null) user.setBio(bio.trim());
        if (profilePhoto != null && !profilePhoto.trim().isEmpty()) user.setProfilePhoto(profilePhoto.trim());

        UserMaster saved = userRepository.save(user);
        auditLogService.log(email, "ADMIN_PROFILE_UPDATED", "Administrator updated profile details", ip);
        return saved;
    }

    @Transactional
    public UserMaster createStudent(String name, String email, String mobile, String rawPassword, String registrationNumber,
                                    String rollNumber, String program, String department, String semester,
                                    String academicYear, String batch, String section, String adminEmail, String ip) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("An account with email " + email + " already exists.");
        }
        String cleanReg = (registrationNumber != null && !registrationNumber.trim().isEmpty()) 
                ? registrationNumber.trim().toUpperCase() 
                : "STU-" + System.currentTimeMillis() % 100000;

        UserMaster student = new UserMaster(email, passwordEncoder.encode(rawPassword), "ROLE_STUDENT", name, mobile, cleanReg);
        student.setRollNumber(rollNumber);
        student.setProgram(program != null && !program.trim().isEmpty() ? program : "B.Tech CSE");
        student.setDepartment(department != null && !department.trim().isEmpty() ? department : "Computer Science & Engineering");
        student.setSemester(semester != null && !semester.trim().isEmpty() ? semester : "1st Semester");
        student.setAcademicYear(academicYear != null && !academicYear.trim().isEmpty() ? academicYear : "1st Year");
        student.setBatch(batch != null && !batch.trim().isEmpty() ? batch : "2024 - 2028");
        student.setSection(section != null && !section.trim().isEmpty() ? section : "Section A");
        student.setStatus("ACTIVE");
        UserMaster saved = userRepository.save(student);

        // Pre-approve or claim registration number
        verifiedRegistrationRepository.findByRegistrationNumberIgnoreCase(cleanReg).ifPresentOrElse(vr -> {
            vr.setUsed(true);
            vr.setUsedByEmail(email);
            verifiedRegistrationRepository.save(vr);
        }, () -> {
            VerifiedRegistration vr = new VerifiedRegistration(cleanReg, "ROLE_STUDENT", name, student.getDepartment());
            vr.setUsed(true);
            vr.setUsedByEmail(email);
            verifiedRegistrationRepository.save(vr);
        });

        auditLogService.log(adminEmail, "STUDENT_CREATED_BY_ADMIN", "Created student: " + name + " (" + email + ")", ip);
        return saved;
    }

    @Transactional
    public UserMaster createFaculty(String name, String email, String mobile, String rawPassword, String registrationNumber,
                                    String department, String designation, String qualification,
                                    String specialization, String experience, String joiningDate, String adminEmail, String ip) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("An account with email " + email + " already exists.");
        }
        String cleanReg = (registrationNumber != null && !registrationNumber.trim().isEmpty())
                ? registrationNumber.trim().toUpperCase()
                : "FAC-" + System.currentTimeMillis() % 100000;

        UserMaster faculty = new UserMaster(email, passwordEncoder.encode(rawPassword), "ROLE_FACULTY", name, mobile, cleanReg);
        faculty.setDepartment(department != null && !department.trim().isEmpty() ? department : "Computer Science & Engineering");
        faculty.setDesignation(designation != null && !designation.trim().isEmpty() ? designation : "Assistant Professor");
        faculty.setQualification(qualification != null && !qualification.trim().isEmpty() ? qualification : "M.Tech / Ph.D.");
        faculty.setSpecialization(specialization != null && !specialization.trim().isEmpty() ? specialization : "Computer Science");
        faculty.setExperience(experience != null && !experience.trim().isEmpty() ? experience : "3+ Years");
        faculty.setJoiningDate(joiningDate != null && !joiningDate.trim().isEmpty() ? joiningDate : java.time.LocalDate.now().toString());
        faculty.setStatus("ACTIVE");
        UserMaster saved = userRepository.save(faculty);

        verifiedRegistrationRepository.findByRegistrationNumberIgnoreCase(cleanReg).ifPresentOrElse(vr -> {
            vr.setUsed(true);
            vr.setUsedByEmail(email);
            verifiedRegistrationRepository.save(vr);
        }, () -> {
            VerifiedRegistration vr = new VerifiedRegistration(cleanReg, "ROLE_FACULTY", name, faculty.getDepartment());
            vr.setUsed(true);
            vr.setUsedByEmail(email);
            verifiedRegistrationRepository.save(vr);
        });

        auditLogService.log(adminEmail, "FACULTY_CREATED_BY_ADMIN", "Created faculty: " + name + " (" + email + ")", ip);
        return saved;
    }

    @Transactional
    public void resetUserPassword(Long userId, String newPassword, String adminEmail, String ip) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);
            auditLogService.log(adminEmail, "USER_PASSWORD_RESET", "Admin reset password for user: " + user.getEmail(), ip);
        });
    }

    @Transactional
    public void changePassword(String email, String currentPassword, String newPassword, String ip) {
        UserMaster user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + email));

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new IllegalArgumentException("Current password is incorrect.");
        }

        if (newPassword == null || newPassword.trim().length() < 6) {
            throw new IllegalArgumentException("New password must be at least 6 characters long.");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        auditLogService.log(email, "PASSWORD_CHANGED", "User successfully changed password", ip);
    }

    public Optional<UserMaster> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<UserMaster> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public List<UserMaster> getAllUsers() {
        return userRepository.findAll();
    }

    public List<UserMaster> getUsersByRole(String role) {
        return userRepository.findByRole(role);
    }

    public void updateStatus(Long userId, String newStatus, String adminEmail, String ip) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setStatus(newStatus);
            userRepository.save(user);
            auditLogService.log(adminEmail, "USER_STATUS_CHANGE", "Updated status of " + user.getEmail() + " to " + newStatus, ip);
        });
    }

    public void updateRole(Long userId, String newRole, String adminEmail, String ip) {
        userRepository.findById(userId).ifPresent(user -> {
            String role = newRole.toUpperCase();
            if (!role.startsWith("ROLE_")) role = "ROLE_" + role;
            user.setRole(role);
            userRepository.save(user);
            auditLogService.log(adminEmail, "USER_ROLE_CHANGE", "Updated role of " + user.getEmail() + " to " + role, ip);
        });
    }

    public void deleteUser(Long userId, String adminEmail, String ip) {
        userRepository.findById(userId).ifPresent(user -> {
            // Free up the registration number if present
            if (user.getRegistrationNumber() != null && !user.getRegistrationNumber().isEmpty()) {
                verifiedRegistrationRepository.findByRegistrationNumberIgnoreCase(user.getRegistrationNumber()).ifPresent(v -> {
                    v.setUsed(false);
                    v.setUsedByEmail(null);
                    verifiedRegistrationRepository.save(v);
                });
            }
            userRepository.delete(user);
            auditLogService.log(adminEmail, "USER_DELETED", "Deleted user " + user.getEmail(), ip);
        });
    }

    // Admin verified registration management
    public VerifiedRegistration addVerifiedRegistration(String registrationNumber, String role, String allocatedName, String department, String adminEmail, String ip) {
        String cleanRegNum = registrationNumber.trim().toUpperCase();
        if (verifiedRegistrationRepository.existsByRegistrationNumberIgnoreCase(cleanRegNum)) {
            throw new IllegalArgumentException("Registration Number " + cleanRegNum + " already exists in the database.");
        }

        VerifiedRegistration vr = new VerifiedRegistration(cleanRegNum, role, allocatedName, department);
        VerifiedRegistration saved = verifiedRegistrationRepository.save(vr);
        auditLogService.log(adminEmail, "REGISTRATION_NUMBER_ADDED", "Added authorized registration: " + cleanRegNum + " for " + role, ip);
        return saved;
    }

    public List<VerifiedRegistration> getAllVerifiedRegistrations() {
        return verifiedRegistrationRepository.findAllByOrderByCreatedAtDesc();
    }

    public void deleteVerifiedRegistration(Long id, String adminEmail, String ip) {
        verifiedRegistrationRepository.findById(id).ifPresent(vr -> {
            verifiedRegistrationRepository.delete(vr);
            auditLogService.log(adminEmail, "REGISTRATION_NUMBER_DELETED", "Deleted authorized registration: " + vr.getRegistrationNumber(), ip);
        });
    }

    public long countTotalUsers() { return userRepository.count(); }
    public long countByRole(String role) { return userRepository.countByRole(role); }
    public long countByStatus(String status) { return userRepository.countByStatus(status); }
}
