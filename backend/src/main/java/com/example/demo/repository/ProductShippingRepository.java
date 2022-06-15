package com.example.demo.repository;

import com.example.demo.model.ProductShipping;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductShippingRepository extends JpaRepository<ProductShipping, Long>, JpaSpecificationExecutor<ProductShipping> {

}