package com.example.demo.model;
import lombok.Data;
import lombok.experimental.Accessors;
import javax.persistence.*;
import java.io.Serializable;


@Data
@Entity
@Accessors(chain = true)
@Table(name = "products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "product_id", nullable = false)
    private Long productId;

    @Column(name = "product_name", nullable = false)
    private String productName;

    @Column(name = "producer_name", nullable = false)
    private String producerName;

    @Column(name = "unit_measure", nullable = false)
    private String unitMeasure;

    @Column(name = "price_per_unit")
    private Float pricePerUnit;

    @Column(name = "price_per_box")
    private Float pricePerBox;

    @Column(name = "price_per_pallet")
    private Float pricePerPallet;

    @Column(name = "units_per_box")
    private Long unitsPerBox;

    @Column(name = "units_per_pallet")
    private Long unitsPerPallet;

    @Column(name = "category")
    private String category;

    @Column(name = "stock")
    private Double stock;

    @Column(name = "weight")
    private Double weight;

    @Override
    public String toString() {
        return "Products{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", producerName='" + producerName + '\'' +
                ", unitMeasure='" + unitMeasure + '\'' +
                ", pricePerUnit=" + pricePerUnit +
                ", pricePerBox=" + pricePerBox +
                ", pricePerPallet=" + pricePerPallet +
                ", unitsPerBox=" + unitsPerBox +
                ", unitsPerPallet=" + unitsPerPallet +
                ", category='" + category + '\'' +
                ", stock=" + stock +
                ", weight=" + weight +
                '}';
    }


}
