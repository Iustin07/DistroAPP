package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class ProductShippingVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "psId can not null")
    private Long psId;
    private Long psIdTransport;

    private Long psProductId;

    private double productQuantity;

    private String unityMeasure;
    private double productValue;

}
