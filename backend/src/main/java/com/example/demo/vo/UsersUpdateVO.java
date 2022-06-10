package com.example.demo.vo;


import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
public class UsersUpdateVO implements Serializable {
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
    private Long enabled;

}
