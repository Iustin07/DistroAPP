package com.example.demo.dto;


import com.example.demo.model.ProductShipping;
import com.example.demo.model.Review;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Data
public class TransportDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long idTransport;

    private String producer;

    private LocalDate dateArrive;

    private String driverPhoneNumber;

    private String truckRegistrationNumber;

    private String driverName;

    private boolean retour;

    private double valueOfProducts;
    private boolean received;
    private List<ProductShipping> productShippingList;
    private Review review;
}
