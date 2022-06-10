package com.example.demo.dto;


import com.example.demo.model.Client;
import com.example.demo.model.OrderProducts;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Data
public class OrderDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long orderId;

    private LocalDate orderData;

    private Long orderSellerAgent;

    private Client client;

    private Double orderPaymentValue;

    private Double totalWeight;
    private List<OrderProducts> products;

}
