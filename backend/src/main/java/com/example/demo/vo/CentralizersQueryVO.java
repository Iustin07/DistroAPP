package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class CentralizersQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private LocalDate creationDate;

    private Long deliverDriver;

}
