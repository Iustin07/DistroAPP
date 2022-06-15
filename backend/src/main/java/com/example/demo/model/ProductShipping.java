package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "products_shipping")
public class ProductShipping implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "ps_id")
    private Long psId;

    @Column(name = "ps_id_transport")
    private Long psIdTransport;

//    @Column(name = "ps_product_id")
//    private Long psProductId;
    @OneToOne()
    @JoinColumn(name = "ps_product_id", referencedColumnName = "product_id")
    private Product product;
    @Column(name = "product_quantity")
    private double productQuantity;
    @Column(name = "unity_measure")
    private String unityMeasure;
    @Column(name="product_value")
    private double productValue;

}
