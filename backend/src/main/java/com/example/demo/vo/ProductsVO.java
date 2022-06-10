package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class ProductsVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long productId;

    @NotNull(message = "productName can not null")
    private String productName;

    @NotNull(message = "producerName can not null")
    private String producerName;

    @NotNull(message = "unitMeasure can not null")
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
