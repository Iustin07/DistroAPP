package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;

@Data
public class ProductShippingDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long psId;

    private Long psIdTransport;

    private Long psProductId;

    private double productQuantity;

    private String unityMeasure;

}
