package com.example.lms;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderUtil {

    public static void main(String[] args) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String admin = encoder.encode("admin123");
        String student = encoder.encode("student123");
        String faculty = encoder.encode("faculty123");

        System.out.println("Admin: " + admin);
        System.out.println("Student: " + student);
        System.out.println("Faculty: " + faculty);
    }
}