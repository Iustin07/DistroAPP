package com.example.demo.dto;


import lombok.Data;

import java.io.Serializable;

@Data
public class ReviewDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long revId;

    private Long transportId;

    private String textReview;

    private double rating;

}
