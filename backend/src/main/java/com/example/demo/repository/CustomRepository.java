package com.example.demo.repository;

import com.example.demo.model.CustomCentralizer;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;

public interface CustomRepository {
    List<CustomCentralizer> getSummarizeCentralizer(Long id);
    double getIncome();
    List<Long> topFiveProducts();
    Map<String,Double> getAnulStats();
}
