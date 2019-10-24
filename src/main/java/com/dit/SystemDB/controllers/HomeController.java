package com.dit.SystemDB.controllers;

import org.springframework.web.bind.annotation.GetMapping;

public class HomeController {

    @GetMapping(value = {"/welcome", "/", "/home"})
    public String index() {
        return "index";
    }
}
