package com.example.demo.dto;


import com.example.demo.model.Order;
import lombok.Data;

import java.io.Serializable;

@Data
public class CentralizerOrdersDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long centralizerId;
    private Order order;

}
