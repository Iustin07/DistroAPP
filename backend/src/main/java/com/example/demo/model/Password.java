package com.example.demo.model;

import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
public class Password implements Serializable {
    private static final long serialVersionUID = 1L;
    @NotNull(message="old password should not be nul or empty")
private String oldPassword;
    @NotNull(message="new password should not be nul or empty")
private  String newPassword;
}
