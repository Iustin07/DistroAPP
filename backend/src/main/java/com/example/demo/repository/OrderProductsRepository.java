package com.example.demo.repository;

import com.example.demo.model.OrderProducts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface OrderProductsRepository extends JpaRepository<OrderProducts, Long>, JpaSpecificationExecutor<OrderProducts> {

}