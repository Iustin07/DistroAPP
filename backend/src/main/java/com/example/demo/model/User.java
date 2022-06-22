package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;
import net.minidev.json.annotate.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "username", nullable = false)
    private String username;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "phone_number", nullable = false)
    private String phoneNumber;

    @Column(name = "address", nullable = false)
    private String address;
    @ManyToOne
    @JoinColumn(name="user_role", nullable=false)
    private Role role;
    @Column(name = "salary", nullable = false)
    private Double salary;

    @Column(name = "created_on", insertable = false)
    private Date createdOn;

    @Column(name = "driver_license")
    private String driverLicense;
    @JsonIgnore
    @Column(name = "enabled")
    private Long enabled;

    @Override
    public String toString() {
        return "Users{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", address='" + address + '\'' +
                ", role=" + role +
                ", salary=" + salary +
                ", createdOn=" + createdOn +
                ", driverLicense='" + driverLicense + '\'' +
                ", enabled=" + enabled +
                '}';
    }
}
