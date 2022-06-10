package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class UsersQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long userId;

    private String username;

    private String passwordHash;

    private String phoneNumber;

    private String address;

    private Long userRole;

    private Double salary;

    private Date createdOn;

    private String driverLicense;

    private Long enabled;

}
