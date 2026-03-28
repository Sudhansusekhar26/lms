
package com.example.lms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Toyota {
    private final Car c;
    @Autowired
    public Toyota (Car c) { // spring injects thr engine bean here
        this.c = c;
    }

    public String drive(){
        return c.startCar(); //Calling Car method
    }
}