package com.example.lms.controller;

import com.example.lms.model.UserMaster;
import com.example.lms.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            @RequestParam(value = "registered", required = false) String registered,
                            Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
            return "redirect:/dashboard";
        }

        if (error != null) {
            model.addAttribute("errorMessage", "Invalid email or password, or account is suspended.");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "You have been logged out successfully.");
        }
        if (registered != null) {
            model.addAttribute("successMessage", "Account created successfully with verified Registration Number! Please sign in.");
        }
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
            return "redirect:/dashboard";
        }
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam("name") String name,
                               @RequestParam("email") String email,
                               @RequestParam("mobile") String mobile,
                               @RequestParam("password") String password,
                               @RequestParam(value = "role", defaultValue = "ROLE_STUDENT") String role,
                               @RequestParam("registrationNumber") String registrationNumber,
                               HttpServletRequest request,
                               Model model) {
        try {
            String ip = request.getRemoteAddr();
            userService.registerUser(name, email, mobile, password, role, registrationNumber, ip);
            return "redirect:/login?registered=true";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("enteredName", name);
            model.addAttribute("enteredEmail", email);
            model.addAttribute("enteredMobile", mobile);
            model.addAttribute("enteredRole", role);
            model.addAttribute("enteredRegNum", registrationNumber);
            return "register";
        }
    }

    @GetMapping("/dashboard")
    public String routeToDashboard(HttpSession session) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
            String email = auth.getName();
            session.setAttribute("email", email);

            userService.getUserByEmail(email).ifPresent(user -> {
                session.setAttribute("userName", user.getName());
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("regNumber", user.getRegistrationNumber());
            });

            for (GrantedAuthority authority : auth.getAuthorities()) {
                String role = authority.getAuthority();
                if ("ROLE_ADMIN".equals(role)) {
                    return "redirect:/admin/dashboard";
                } else if ("ROLE_FACULTY".equals(role)) {
                    return "redirect:/faculty/dashboard";
                } else if ("ROLE_STUDENT".equals(role)) {
                    return "redirect:/student/dashboard";
                }
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/profile")
    public String profileRedirect() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
            for (GrantedAuthority authority : auth.getAuthorities()) {
                String role = authority.getAuthority();
                if ("ROLE_ADMIN".equals(role)) {
                    return "redirect:/admin/profile";
                } else if ("ROLE_FACULTY".equals(role)) {
                    return "redirect:/faculty/profile";
                } else if ("ROLE_STUDENT".equals(role)) {
                    return "redirect:/student/profile";
                }
            }
        }
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler().logout(request, response, auth);
        }
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login?logout=true";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}
