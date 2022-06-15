package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class TransportQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long idTransport;

    private String producer;

    private LocalDate dateArrive;

    private String driverPhoneNumber;

    private String truckRegistrationNumber;

    private String driverName;

    private Boolean retour;

    private Double valueOfProducts;

}
