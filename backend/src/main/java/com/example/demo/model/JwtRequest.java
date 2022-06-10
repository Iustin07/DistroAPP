package com.example.demo.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class JwtRequest implements Serializable {

    private String userName;
    private String userPassword;

    public JwtRequest() {
    }

    public JwtRequest(String username, String password) {
        this.setUsername(username);
        this.setUserPassword(password);
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUsername(String username) {
        this.userName = username;
    }

    public String getUserPassword() {
        return this.userPassword;
    }
    public void setUserPassword(String password) {
        this.userPassword = password;
    }
}