package com.dit.SystemDB.controller;

import com.dit.SystemDB.request.SignUpRequest;
import com.dit.SystemDB.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/signup")
    public String signUpForm(Model model) {

        model.addAttribute("signUpForm", new SignUpRequest());
        return "signup";
    }

    @PostMapping("/signup")
    public String signUp(@ModelAttribute("signUpForm")  @Valid SignUpRequest signUpRequest,
                         BindingResult bindingResult,
                         Model model) {

        return userService.signUp(signUpRequest, bindingResult, model);
    }
}
