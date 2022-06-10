package com.example.demo.vo;


import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
public class ProductsUpdateVO implements Serializable {
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
