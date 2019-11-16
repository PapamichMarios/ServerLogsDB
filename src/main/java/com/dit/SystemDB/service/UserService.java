package com.dit.SystemDB.service;

import com.dit.SystemDB.model.User;
import com.dit.SystemDB.repository.UserRepository;
import com.dit.SystemDB.request.SignUpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public String signUp(SignUpRequest signUpRequest,
                         BindingResult bindingResult,
                         Model model) {

        // lookup user in database by email
        if (userRepository.findByEmail(signUpRequest.getEmail()) != null) {
            model.addAttribute("errorMessage", "The email given is already in use.");
            bindingResult.rejectValue("email", "The email given is already in use.");
        }

        //check for errors
        if(bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors ) {
                System.out.println (error.getObjectName() + " - " + error.getDefaultMessage());
            }

           return "signup";
        }

        //create a user object
        User user = new User(signUpRequest);

        //encrypt password
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        //save user
        userRepository.save(user);

        return "index";
    }
}