package com.example.demo.vo;


import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
public class OrderProductsUpdateVO extends OrderProductsVO implements Serializable {
    private static final long serialVersionUID = 1L;

}
