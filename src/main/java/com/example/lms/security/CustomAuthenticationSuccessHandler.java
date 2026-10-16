package com.example.lms.security;

import com.example.lms.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        HttpSession session = request.getSession();
        String email = authentication.getName();
        session.setAttribute("email", email);

        userRepository.findByEmail(email).ifPresent(user -> {
            user.setLastLogin(java.time.LocalDateTime.now());
            userRepository.save(user);
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("regNumber", user.getRegistrationNumber());
        });

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            String role = authority.getAuthority();
            if ("ROLE_ADMIN".equals(role)) {
                response.sendRedirect("/admin/dashboard");
                return;
            } else if ("ROLE_FACULTY".equals(role)) {
                response.sendRedirect("/faculty/dashboard");
                return;
            } else if ("ROLE_STUDENT".equals(role)) {
                response.sendRedirect("/student/dashboard");
                return;
            }
        }

        response.sendRedirect("/dashboard");
    }
}
