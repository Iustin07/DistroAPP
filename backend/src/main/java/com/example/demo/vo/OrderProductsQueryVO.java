package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;

@Data
public class OrderProductsQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long opId;

    private Long opOrderId;

    private Long opProductId;

    private Long productUnits;

}
