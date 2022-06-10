package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;


@Data
public class OrdersVO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long orderId;
    private LocalDate orderData;
    private Long orderSellerAgent;

    @NotNull(message = "orderClientId can not null")
    private Long orderClientId;

    private Double orderPaymentValue;

    private Double totalWeight;
    private List<OrderProductsVO> productsIds;

}
