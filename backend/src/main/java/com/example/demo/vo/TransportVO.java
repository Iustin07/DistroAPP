package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;


@Data
public class TransportVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long idTransport;

    @NotNull(message = "producer can not null")
    private String producer;

    @NotNull(message = "dateArrive can not null")
    private LocalDate dateArrive;

    @NotNull(message = "driverPhoneNumber can not null")
    private String driverPhoneNumber;
    private String truckRegistrationNumber;
    private String driverName;
    private Boolean retour;
    private double valueOfProducts;

}
