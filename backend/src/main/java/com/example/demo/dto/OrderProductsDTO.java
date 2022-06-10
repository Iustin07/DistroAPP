package com.example.demo.dto;


import com.example.demo.model.Product;
import lombok.Data;

import java.io.Serializable;

@Data
public class OrderProductsDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long opId;
    //private Long opOrderId;
    private Long productUnits;
    private Product product;
}
