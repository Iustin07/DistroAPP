package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;

@Data
public class VehicleDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String registrationNumber;

    private String model;

    private String producer;

    private Float capacity;

    private Integer fuelCapacity;

    private String typeOfCar;

}
