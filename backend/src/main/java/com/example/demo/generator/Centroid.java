package com.example.demo.generator;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Map;
@Data
@AllArgsConstructor
public class Centroid {
    Map<String,Double> centroidCoordonates;
}
