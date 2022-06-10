package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;


@Data
public class UsersVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long userId;
    @NotNull(message = "username can not null")
    private String username;

    @NotNull(message = "passwordHash can not null")
    private String passwordHash;

    @NotNull(message = "phoneNumber can not null")
    private String phoneNumber;

    @NotNull(message = "address can not null")
    private String address;

    @NotNull(message = "userRole can not null")
    private String userRole;

    @NotNull(message = "salary can not null")
    private Double salary;

    private Date createdOn;

    private String driverLicense;

    private Long enabled;

}
