package com.example.demo.dto;


import com.example.demo.model.CentralizerOrders;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Data
public class CentralizerDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private LocalDate creationDate;
    private String driverName;
    private List<CentralizerOrders> orders;
}
