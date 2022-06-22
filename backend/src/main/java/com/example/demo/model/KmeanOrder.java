package com.example.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Map;

@Data
@AllArgsConstructor
public class KmeanOrder {
private Long orderId;
private Double latitude;
private Double longitude;

public Map<String,Double>getCoordonates(){
    Map<String,Double> coordonates=new HashMap<>();
    coordonates.put("latitude",latitude);
    coordonates.put("longitude",longitude);
    return  coordonates;
}
}
