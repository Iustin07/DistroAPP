package com.example.demo.model;

import com.fasterxml.jackson.databind.jsonschema.JsonSerializableSchema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@JsonSerializableSchema
@Data
@NoArgsConstructor
public class DividerObject implements Serializable {
        private static final long serialVersionUID = 1L;
        private int palletQuantity;
        private int boxQuantiy;
        private int bucQuantity;
    }

