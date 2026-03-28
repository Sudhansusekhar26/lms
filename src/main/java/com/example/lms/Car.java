package com.example.lms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Car {
    private String color="white";
    private final Engine engine;
    @Autowired
    public Car(Engine engine){  // Spring injects the engoine bean here
        this.engine = engine;
    }
    public String startCar(){
        return engine.start();
    }
}
