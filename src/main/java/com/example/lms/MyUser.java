package com.example.lms;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
public class MyUser {

    @Id
    @Column(nullable = false, unique = true)
private String username;

@Column(nullable = false)
private String password;

@Column(nullable = false)
private String role;

public MyUser(){
}
public MyUser(String username,String password,String role){
    this.username=username;
    this.password=password;
    this.role=role;
}

public String getUsername(){
    return username;
}
public void setUsername(String username){
 this.username=username;
  
}
public String getPassword(){
    return password;
}
public void setPassword(String password){
        this.password=password;

}
public String getRole(){
    return role;
}
public void setRole(String role){
    this.role=role;
}
}
