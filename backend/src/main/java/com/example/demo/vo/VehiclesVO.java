package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class VehiclesVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "registrationNumber can not null")
    private String registrationNumber;

    @NotNull(message = "model can not null")
    private String model;

    @NotNull(message = "producer can not null")
    private String producer;

    @NotNull(message = "capacity can not null")
    private Float capacity;

    @NotNull(message = "fuelCapacity can not null")
    private Integer fuelCapacity;

    @NotNull(message = "typeOfCar can not null")
    private String typeOfCar;

}
