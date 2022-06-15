package com.example.demo.vo;


import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
public class TransportUpdateVO  implements Serializable {
    private static final long serialVersionUID = 1L;
    private List<ProductShippingVO> products;
    private ReviewsVO review;
    private double valueOfProducts;
}
