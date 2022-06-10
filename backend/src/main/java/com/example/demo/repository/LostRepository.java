package com.example.demo.repository;

import com.example.demo.model.Lost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface LostRepository extends JpaRepository<Lost, Long>, JpaSpecificationExecutor<Lost> {

}