package com.example.lms;
import java.util.List;
import java.util.Map;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
public class AdminController {
    @GetMapping("/adashboard")
    public String adashboard() {
        return "adashboard";
    }
    @Autowired
    JdbcTemplate jdbc;
      @GetMapping("admin/users")
public String users(Model model) {
    List<Map<String,Object>> li = jdbc.queryForList("select * from user_master");
         model.addAttribute("user_master", li);
    return "admin/users";
    }
    @PostMapping("/users")
    public String users_manage(Model model,@RequestParam("btn") String btn , @RequestParam("email") String email) {
        if(btn.equals("delete")){
            String sql="delete from user_master where email=?";
            jdbc.update(sql,email);
            return users(model);
        }
       if("edit".equals(btn)) {
 List<Map<String,Object>> li = jdbc.queryForList("select * from user_master where email='"+email+"'");
         model.addAttribute("user_master", li);
return "edituser";
    }
    return users(model);
}

@PostMapping("/updateusers")
public String updateUsers(
        @RequestParam("email") String email,
        @RequestParam("name") String name,
        @RequestParam("role") String role,
        @RequestParam("mobile") String mobile,
        Model model) {

    String sql = "update user_master set name=?, role=?, mobile=? where email=?";
    jdbc.update(sql, name, role, mobile, email);
    return users(model);  
}
}

