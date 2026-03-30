package com.example.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/api")
public class UserVersioningController {

    // V1: returns just a string
    @GetMapping("/v1/user")
    public String getUserV1() {
        return " User v1: John";
    }

    // V2: returns a structured object (JSON)
    @GetMapping("/v2/user")
    public UserV2 getUserV2() {
        return new UserV2("John", "Doe");
    }
}