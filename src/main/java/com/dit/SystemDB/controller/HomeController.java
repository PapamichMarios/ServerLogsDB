package com.dit.SystemDB.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping(value = {"/welcome", "/", "/home", "/signup", "/login", "/procedure1"})
    public String index() {
        return "index";
    }
}
