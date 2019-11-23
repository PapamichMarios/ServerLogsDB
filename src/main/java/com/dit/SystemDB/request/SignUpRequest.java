package com.dit.SystemDB.request;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class SignUpRequest {

    @NotNull
    @Size(min=4, max=40)
    private String username;

    @NotNull
    @Size(min=2, max=40)
    private String email;

    @NotNull
    @Size(min=6, max=40)
    private String password;

    @Size(min=6, max=100)
    private String address;

    public SignUpRequest() { }

    public SignUpRequest(@NotNull @Size(min = 4, max = 40) String username, @NotNull @Size(min = 2, max = 40) String email, @NotNull @Size(min = 6, max = 40) String password, @Size(min = 6, max = 100) String address) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.address = address;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
