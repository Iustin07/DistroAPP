package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "centralizer_orders")
public class CentralizerOrders implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "centralizer_id")
    private Long centralizerId;
     @OneToOne
    @JoinColumn(name="order_id", referencedColumnName = "order_id")
    private Order order;
//    @Column(name = "order_id")
//    private Long orderId;

}
