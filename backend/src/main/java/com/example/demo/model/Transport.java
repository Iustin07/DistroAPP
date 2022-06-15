package com.example.demo.model;

import lombok.Data;
import lombok.Value;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "transports")
public class Transport implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_transport")
    private Long idTransport;

    @Column(name = "producer", nullable = false)
    private String producer;

    @Column(name = "date_arrive", nullable = false)
    private LocalDate dateArrive;

    @Column(name = "driver_phone_number", nullable = false)
    private String driverPhoneNumber;

    @Column(name = "truck_registration_number")
    private String truckRegistrationNumber;

    @Column(name = "driver_name")
    private String driverName;

    @Column(name = "retour")
    private Boolean retour;

    @Column(name = "value_of_products")
    private double valueOfProducts;

    @Column(name="received")
    private boolean received;
    @OneToMany(orphanRemoval = true, cascade = CascadeType.ALL)
    @JoinColumn(name="ps_id_transport")
    List<ProductShipping> productShippingList=new ArrayList<>();
    @OneToOne(orphanRemoval = true,cascade = CascadeType.ALL)
    @JoinColumn(name="id_transport", referencedColumnName = "transport_id")
    private Review review;
    public void addShippingProduct(ProductShipping product){
        this.productShippingList.add(product);
    }
}
