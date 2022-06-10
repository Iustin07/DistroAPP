package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;

@Data
public class ProductDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long productId;

    private String productName;

    private String producerName;

    private String unitMeasure;

    private Float pricePerUnit;

    private Float pricePerBox;

    private Float pricePerPallet;

    private Long unitsPerBox;

    private Long unitsPerPallet;

    private String category;

    private Double stock;

    private Double weight;

}
