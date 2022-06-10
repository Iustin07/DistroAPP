package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "vehicles")
public class Vehicle implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "registration_number", nullable = false)
    private String registrationNumber;

    @Column(name = "model", nullable = false)
    private String model;

    @Column(name = "producer", nullable = false)
    private String producer;

    @Column(name = "capacity", nullable = false)
    private Float capacity;

    @Column(name = "fuel_capacity", nullable = false)
    private Integer fuelCapacity;

    @Column(name = "type_of_car", nullable = false)
    private String typeOfCar;

    @OneToMany(mappedBy="vehicle")
    private List<VehicleRevisions> revisions;
}
