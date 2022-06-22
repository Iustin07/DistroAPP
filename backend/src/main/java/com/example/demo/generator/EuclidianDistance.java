package com.example.demo.generator;

import lombok.Data;

import java.util.Map;
@Data
public class EuclidianDistance {
    public double calculateDistance(Map<String,Double> firstOrderCoordonates, Map<String,Double>secondOrderCoodonates){
        double sum = 0;
        for (String key : firstOrderCoordonates.keySet()) {
            Double x = firstOrderCoordonates.get(key);
            Double y = secondOrderCoodonates.get(key);
            sum += Math.pow(x - y, 2);

        }
        return Math.sqrt(sum);
    }
    }

