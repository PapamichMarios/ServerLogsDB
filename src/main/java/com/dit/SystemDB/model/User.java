package com.dit.SystemDB.model;

import com.dit.SystemDB.request.SignUpRequest;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name= "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "id")
    private Long id;

    @Column(name="username", nullable=false, unique=true)
    @NotEmpty(message="Please provide a username")
    private String username;

    @Column(name= "email", nullable=false, unique = true)
    @Email(message = "Please provide a valid e-mail")
    @NotEmpty(message = "Please provide an e-mail")
    private String email;

    @Column(name= "password")
    @NotEmpty(message="Please provide a password")
    private String password;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "user_roles",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles = new HashSet<>();

    public User () {}

    public User(Long id, @NotEmpty(message = "Please provide a username") String username, @Email(message = "Please provide a valid e-mail") @NotEmpty(message = "Please provide an e-mail") String email, @NotEmpty(message = "Please provide a password") String password, Set<Role> roles) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.roles = roles;
    }

    public User(SignUpRequest signUpRequest){
        this.username = signUpRequest.getUsername();
        this.email = signUpRequest.getEmail();
        this.password = signUpRequest.getPassword();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void addRole(Role role) { this.roles.add(role); }
}