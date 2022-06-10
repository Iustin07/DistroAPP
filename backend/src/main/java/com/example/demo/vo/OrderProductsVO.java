package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Map;


@Data
public class OrderProductsVO implements Serializable {
    private static final long serialVersionUID = 1L;

    //@NotNull(message = "opId can not null")
//    private Long opId;
//
//    private Long opOrderId;
//
  private Long opProductId;
//
   private Long productUnits;

}
