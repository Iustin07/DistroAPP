package com.example.demo.model;

import com.fasterxml.jackson.databind.jsonschema.JsonSerializableSchema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import java.io.Serializable;
@AllArgsConstructor
@JsonSerializableSchema
@Data
@NoArgsConstructor
public class CustomCentralizer  implements Serializable {
    private static final long serialVersionUID = 1L;
    private String productName;
    private Long quantity;
    private String measureUnit;

}
