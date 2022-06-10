package com.example.demo.dto;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class UserDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long userId;

    private String username;

    private String passwordHash;

    private String phoneNumber;

    private String address;

    private String userRole;

    private Double salary;

    private Date createdOn;

    private String driverLicense;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY )
    private Long enabled;

}
