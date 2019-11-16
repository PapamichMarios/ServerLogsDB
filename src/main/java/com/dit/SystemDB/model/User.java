package com.dit.SystemDB.model;

import com.dit.SystemDB.request.SignUpRequest;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name= "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "id")
    private int id;

    @Column(name= "email", nullable=false, unique = true)
    @Email(message = "Please provide a valid e-mail")
    @NotEmpty(message = "Please provide an e-mail")
    private String email;

    @Column(name= "password")
    @NotEmpty(message="Please provide a password")
    private String password;

    public User () {}

    public User(int id, @Email(message = "Please provide a valid e-mail") @NotEmpty(message = "Please provide an e-mail") String email, @NotEmpty(message = "Please provide a password") String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }

    public User(SignUpRequest signUpRequest){
        this.email = signUpRequest.getEmail();
        this.password = signUpRequest.getPassword();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}