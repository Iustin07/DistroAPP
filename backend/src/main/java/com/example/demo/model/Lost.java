package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;
import net.minidev.json.annotate.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "loses")
public class Lost implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;
    @OneToOne()
    @JoinColumn(name = "responsable_id", referencedColumnName = "user_id")
    private User user;
    @OneToOne()
    @JoinColumn(name = "product_id", referencedColumnName = "product_id")
    private Product product;
    @Column(name = "quantity")
    private double quantity;

    @Column(name = "date_of_lost", insertable = false)
    private LocalDate dateOfLost;

}
