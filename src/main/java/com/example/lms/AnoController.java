package com.example.lms;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.http.HttpSession;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;


@Controller

public class AnoController {

     @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

@GetMapping("/test")
public ModelAndView test() {

            List<String> li = new ArrayList<>();
        li.add("Jaga");
        li.add("Raja");
        li.add("Aja");
        li.add("Praja");
    ModelAndView obj=new ModelAndView();
  obj.addObject("data",li);
      obj.addObject("name","raja");
      obj.addObject("roll",1234);
    obj.setViewName("test");
    return obj;
}

@GetMapping("/test2")
public String test2(){
    return "test2";
}
@GetMapping("/manage")
public String manage(){
    return "manage";
}
@GetMapping("/changepwd")
public String changepwd(){
    return "changepwd";
}
 

@PostMapping("/calculate")
    public String calculate_data(Model model  , @RequestParam("btn") String btn ,@RequestParam("a") int a,@RequestParam("b") int b ) {
        System.out.println("calculate post method");
      int c=0;
        if(btn.equals("add")){
            c=a+b;
        }else  if(btn.equals("sub")){
            c=a-b;
        }else {
             if(btn.equals("mul")){
            c=a*b;
        }
    } 
        model.addAttribute("result",c);
        return "calculate";
    }

    @GetMapping("/calculate")
    public String calculate() {
                System.out.println("calculate Get method");

        return "calculate";
    }


    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

@PostMapping("/contact")
public String saveContact(
        @RequestParam("name") String name,
        @RequestParam("email") String email,
        @RequestParam("mobile") String mobile,
        @RequestParam("message") String message,
        Model model) {

jdbc.execute("insert into contact_page(name, email, mobile, message) values('" + name + "','" + email + "','" + mobile + "','" + message + "')");
        model.addAttribute("con","success");
    return "contact";   
}

    @GetMapping("/gallery")
    public String gallery() {
        return "gallery";
    }
    @GetMapping("/register")
    public String register() {
        return "register";

    }
    @Autowired
    JdbcTemplate jdbc;
@PostMapping("/register")
public String register_save(
        @RequestParam("name") String name,
        @RequestParam("email") String email,
        @RequestParam("mobile") String mobile,
        @RequestParam("password") String password,
        @RequestParam("role") String role,
        Model model) {
        jdbc.execute("insert into user_master(name, email, mobile, password, role) values('" + name + "','" + email + "','" + mobile + "','" + password + "','" + role + "')");
        model.addAttribute("sms","Register Success");
    return "register";   
    }
        
    @GetMapping("/login")
    public String login() {
        return "login";
    }
@PostMapping("/login")
public String login_chk(HttpSession session ,@RequestParam("email") String email,
                       @RequestParam("password") String password,
                       Model model ) {

ArrayList<String> ali = new ArrayList<String>();
String sql = "Select * From user_master Where email='"+email+"' and password ='"+password+"' ";
jdbc.query(sql,new RowMapper<String>(){
public String mapRow(ResultSet rs, int rowNum) throws SQLException {
        ali.add(rs.getString(1)); //id rs is eq to ali 0 // ali[0]
        ali.add(rs.getString(2)); // name ali[1]
        ali.add(rs.getString(3)); // email  ali[2]
        ali.add(rs.getString(4)); // mobile  ali[3]
        ali.add(rs.getString(6)); // role   ali[4]
        ali.add(rs.getString(7)); // status  ali[5]
         return rs.getString(1);
    }
}) ;

                
// recive user idn & password
// Get match data from database
// If Match

if(!ali.isEmpty()){ // Success
    if(ali.get(5).equals("1")){            // if status is 1   // active user
        session.setAttribute("name",ali.get(1));
        session.setAttribute("email",ali.get(2));
             //Check the role
        if(ali.get(4).equalsIgnoreCase("student")){  //if student
            return"sdashboard";  // Student Dashbord
        }
        if(ali.get(4).equalsIgnoreCase("faculty")){    // if faculty 
            return"fdashboard";  // faculty Dashbord
        }
         if(ali.get(4).equalsIgnoreCase("admin")){  // if admin
            return"adashboard"; // admin Dashbord
        }
        else{   //else 
            model.addAttribute("output","Contact to admin"); // invalid user by admin
        }
    }else{
        model.addAttribute("output","invalid"); // No match   // invalid
    }
    return "login";
    
}
//System.out.println("Chk Login");   
    return "login";

}

@GetMapping("/logout")
public String logout(HttpSession session) {

    session.invalidate();   // Destroy session

    return "redirect:/login";
}

    @GetMapping("/service")
    public String service() {
        return "service";
    }
    @GetMapping("/about")
    public String about() {
        return "about";
    }
    @GetMapping("admin/faq")
    public String faq() {
        return "admin/faq";
    }
     @GetMapping("admin/campus")
    public String campus() {
        return "admin/campus";
    }
     @GetMapping("/access-denied")
    public String access_denied() {
        return "access-denied";
    }
    
}
        