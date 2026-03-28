package com.example.lms;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController

//http://localhost:9090/api2/user/3

@RequestMapping("/api2")
public class UserApplication {
@GetMapping("/user/{id}")
public String getUser(@PathVariable int id){
    return "User ID:"+id;
}

//http://localhost:9090/api2/product/3

@GetMapping("/product/{id}")
public String getProduct(@PathVariable int id){
    return "Product ID:"+id;
}
 
// http://localhost:9090/api2/search?id=12

@GetMapping("/search")
public String search(@RequestParam("id") int id){

    return "Search ID :"+id;
}
}


