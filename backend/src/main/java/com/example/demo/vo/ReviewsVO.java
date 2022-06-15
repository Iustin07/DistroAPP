package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class ReviewsVO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long revId;
    private Long transportId;
    private String textReview;
    private Double rating;

}
