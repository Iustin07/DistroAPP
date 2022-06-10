package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "orders")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long orderId;
    @Column(name = "order_data",insertable = false)
    private LocalDate orderData;

    @Column(name = "order_seller_agent", nullable = false)
    private Long orderSellerAgent;

//    @Column(name = "order_client_id", nullable = false)
//    private Long orderClientId;
@OneToOne
@JoinColumn(name="order_client_id",referencedColumnName = "id_client")
private Client client;
    @Column(name = "order_payment_value")
    private Double orderPaymentValue;

    @Column(name = "total_weight")
    private Double totalWeight;
//    @ManyToMany
//    @JoinTable(
//            name = "order_products",
//            joinColumns = { @JoinColumn(name = "op_order_id") },
//            inverseJoinColumns = { @JoinColumn(name = "op_product_id") }
//    )
//    List<Products> products = new ArrayList<>();
//    public void addProduct(Products product){
//        this.products.add(product);
//    }
    @OneToMany(cascade=CascadeType.ALL,orphanRemoval = true)
    @JoinColumn(name="op_order_id")
    private List<OrderProducts> products=new ArrayList<>();
    public void addProduct(OrderProducts product){
        this.products.add((product));
    }
}
