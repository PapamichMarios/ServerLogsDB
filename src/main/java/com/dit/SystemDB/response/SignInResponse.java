package com.dit.SystemDB.response;

public class SignInResponse {

    private String accessToken;
    private String tokenType = "Bearer";

    private String username;
    private boolean isAdmin; // True is admin else false

    public SignInResponse(String accessToken, String username, boolean isAdmin) {
        this.accessToken = accessToken;
        this.username = username;
        this.isAdmin = isAdmin;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }
}