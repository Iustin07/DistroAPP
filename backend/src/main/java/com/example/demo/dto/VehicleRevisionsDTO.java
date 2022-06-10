package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class VehicleRevisionsDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long revisionId;

    private String revRegistrationNumber;

    private LocalDate revisionDate;

    private Float revisionCost;

}
