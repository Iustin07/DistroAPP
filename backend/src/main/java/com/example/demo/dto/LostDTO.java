package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class LostDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private ProductDTO product;
    private String responsableName;
    private double quantity;
    private LocalDate dateOfLost;

}
