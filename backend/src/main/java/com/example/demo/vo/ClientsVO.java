package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class ClientsVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long idClient;

    @NotNull(message = "clientName can not null")
    private String clientName;

    private String cif;

    private String commerceRegistrationNumber;

    @NotNull(message = "adress can not null")
    private String address;

    @NotNull(message = "clientPhoneNumber can not null")
    private String clientPhoneNumber;

    private Double longitude;

    private Double latitude;

}
