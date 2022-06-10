package com.example.demo.repository;

import com.example.demo.model.CentralizerOrders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface CentralizerOrdersRepository extends JpaRepository<CentralizerOrders, Long>, JpaSpecificationExecutor<CentralizerOrders> {

}