package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;


@Data
public class VehiclesRevisionsVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "revisionId can not null")
    private Long revisionId;

    @NotNull(message = "revRegistrationNumber can not null")
    private String revRegistrationNumber;

    @NotNull(message = "revisionDate can not null")
    private LocalDate revisionDate;

    @NotNull(message = "revisionCost can not null")
    private Float revisionCost;

}
