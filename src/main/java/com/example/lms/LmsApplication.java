package com.example.lms;


import java.util.HashMap;
import java.util.Map;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


 @SpringBootApplication
@RestController
public class LmsApplication {

// @Autowired
//     private Toyota t;
//     @GetMapping("/car")
//     public String ttt(){
//         return t.drive();
//     }



// private GreetingService greetingService;

//  @GetMapping("/greet/{name}")
//     public String greet(@PathVariable String name){
//         return greetingService.greet(name);
//     }

// @SpringBootApplication
// @RestController
// @RequestMapping("/api")
// public class LmsApplication {

// 	@RequestMapping("/hello")
// 	public String sayHello(){
// 		return"Hello API";
// 	}

@Autowired
JdbcTemplate jdbc;
@GetMapping("/get")
public List get_student(){
    List<Map<String,Object>>li=jdbc.queryForList("select * from student");
    return li ;
}

    @PostMapping("/save")
    public Map<String,Object>save_student(@RequestBody Student stu){
        jdbc.execute("insert into student values('"+stu.getRoll()+"','"+stu.getName()+"')");
        Map<String, Object> response=new HashMap<>();
        response.put("message", "Insert Successfully");
        response.put("student",stu);
        return response; 
    }
    @PutMapping("/updates")
    public Map<String, Object> update(@RequestBody Student stu){
        jdbc.execute("update student set name='"+stu.getName()+"' where roll='"+stu.getRoll()+"'");
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Update Successfully");
        response.put("student",stu);
        return response;
    }


	@GetMapping("/greet")
	public String greet() {
		return "hello !";
	}
	@PostMapping("/submit")
	public String submit(@RequestBody String data) {
		return "Data received:"+data;
	}

	@PutMapping("/update")
	public String update() {
		return "update!";
	}
	
	@DeleteMapping("/remove")
	public String delete(){
		return"Delete!";
	}
	






// 	 // http://localhost:9090/hello?name=alok
// 	 @GetMapping("/hello")
// public String hello(@RequestParam("name")String n){
// 	return "hello "+ n;
// }
// // http://localhost:9090/hello?name=alok
// @GetMapping("/hi")
// public String hi(@RequestParam("name")String n){
// 	return "hi "+n;
// }

// @GetMapping({"","/","index"})
// public String index(){
// 	return"hello seeree";
// }

// @RequestMapping( method=RequestMethod.GET ,path="abc")
// public String abc() {
//     return "abcd";
// }
// @RequestMapping( method=RequestMethod.POST ,path="abcd")
// public String abcd() {
//     return "Jai Jagannath";
// }


// // http://localhost:9090/add?f=100&s=200
  
// // @GetMapping("/add")
// // public String add(@RequestParam("f") int a ,@RequestParam("s") int b ){
// // 	return String.valueOf(a+b);
// // }

// @PostMapping("/add")
// public String add(@RequestParam("f") int a ,@RequestParam("s") int b ){
// 	return String.valueOf(a+b);
// }

// public String postMethodName(@RequestBody String entity) {
//     //TODO: process POST request
    
//     return entity;
// }

	public static void main(String[] args) {
		SpringApplication.run(LmsApplication.class, args);
	}
}

