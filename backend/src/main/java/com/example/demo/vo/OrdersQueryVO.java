package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class OrdersQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long orderId;

    private LocalDate orderData;

    private Long orderSellerAgent;

    private Long orderClientId;

    private Double orderPaymentValue;

    private Double totalWeight;

}
