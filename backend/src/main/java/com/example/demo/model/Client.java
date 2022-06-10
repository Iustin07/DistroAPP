package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;
import net.minidev.json.annotate.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "clients")
public class Client implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_client", nullable = false)
    private Long idClient;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Column(name = "cif")
    private String cif;

    @Column(name = "commerce_registration_number")
    private String commerceRegistrationNumber;

    @Column(name = "adress", nullable = false)
    private String address;

    @Column(name = "client_phone_number", nullable = false)
    private String clientPhoneNumber;

    @Column(name = "longitude")
    private Double longitude;

    @Column(name = "latitude")
    private Double latitude;
    @JsonIgnore
    @Column(name = "client_enable")
    private boolean enabled;

}
