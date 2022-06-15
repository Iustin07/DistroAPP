package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "reviews")
public class Review implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "rev_id")
    private Long revId;

    @Column(name = "transport_id")
    private Long transportId;

    @Column(name = "text_review")
    private String textReview;

    @Column(name = "rating")
    private Double rating;

}
