package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;

@Data
public class ClientsQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long idClient;

    private String clientName;

    private String cif;

    private String commerceRegistrationNumber;

    private String adress;

    private String clientPhoneNumber;

    private Double longitude;

    private Double latitude;

}
