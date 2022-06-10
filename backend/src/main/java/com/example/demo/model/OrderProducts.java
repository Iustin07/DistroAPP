package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "order_products")
public class OrderProducts implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "op_id", nullable = false)
    private Long opId;

    @Column(name = "op_order_id")
    private Long opOrderId;

    @OneToOne()
    @JoinColumn(name = "op_product_id", referencedColumnName = "product_id")
    private Product product;

    @Column(name = "product_units")
    private Long productUnits;

}
