package com.dit.SystemDB.service;

import com.dit.SystemDB.exception.AppException;
import com.dit.SystemDB.exception.UserExistsException;
import com.dit.SystemDB.model.Role;
import com.dit.SystemDB.model.RoleName;
import com.dit.SystemDB.model.User;
import com.dit.SystemDB.repository.RoleRepository;
import com.dit.SystemDB.repository.UserRepository;
import com.dit.SystemDB.request.SignInRequest;
import com.dit.SystemDB.request.SignUpRequest;
import com.dit.SystemDB.response.ApiResponse;
import com.dit.SystemDB.response.SignInResponse;
import com.dit.SystemDB.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Collections;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public ResponseEntity<?> signUp(SignUpRequest signUpRequest) {

        //check if the username already exists
        userRepository.findByUsername(signUpRequest.getUsername())
                .ifPresent((s) -> {
                    throw new UserExistsException("The username given is already in use.");
                });

        //check if the email already exists
        userRepository.findByEmail(signUpRequest.getEmail())
                .ifPresent((s) -> {
                    throw new UserExistsException("The email given is already in use.");
                });

        //create the new user
        User user = new User(signUpRequest);

        //encrypt password
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        //add role
        Role userRole = roleRepository.findByName(RoleName.ROLE_USER)
                .orElseThrow(() -> new AppException("User Role not set."));

        user.setRoles(Collections.singleton(userRole));

        User result = userRepository.save(user);

        URI location = ServletUriComponentsBuilder
                .fromCurrentContextPath().path("/api/users/{username}")
                .buildAndExpand(result.getUsername()).toUri();

        return ResponseEntity.created(location).body(new ApiResponse(true, "User registered successfully"));
    }

    public ResponseEntity<?> signIn(SignInRequest signInRequest) {

        //check if the user exists
        User user = userRepository.findByUsername(signInRequest.getUsername())
                .orElseThrow( () -> new AppException("Invalid username or password."));

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        signInRequest.getUsername(),
                        signInRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        return ResponseEntity.ok(new SignInResponse(jwt, user.getUsername(), roleRepository.findRoleAdminById(user.getId())));
    }
}