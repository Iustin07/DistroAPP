package com.example.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "centralizers")
@AllArgsConstructor
@NoArgsConstructor
public class Centralizer implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "creation_date",insertable = false)
    private LocalDate creationDate;
    @OneToOne
    @JoinColumn(name="deliver_driver", referencedColumnName = "user_id")
    private User driver;
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name="centralizer_id")
    private List<CentralizerOrders> orders=new ArrayList<>();
    public void addOrder(CentralizerOrders orderItem){
        this.orders.add(orderItem);
    }
    public double getTotalWeight(){
       return orders.stream().reduce(0.0,(total,element)->total+element.getOrder().getTotalWeight(),Double::sum);
    }
    public double getTotalValue(){
        return orders.stream().reduce(0.0,(total,element)->total+element.getOrder().getOrderPaymentValue(),Double::sum);
    }
}
