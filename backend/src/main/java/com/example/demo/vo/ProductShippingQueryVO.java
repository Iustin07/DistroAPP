package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;

@Data
public class ProductShippingQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long psId;

    private Long psIdTransport;

    private Long psProductId;

    private Long productQuantity;

    private String unityMeasure;

}
