package com.example.lms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class StudentController {
    @GetMapping("/sdashboard")
    public String sdashboard() {
        return "sdashboard";
    }
    
}
