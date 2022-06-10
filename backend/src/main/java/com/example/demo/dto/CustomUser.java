package com.example.demo.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomUser implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long userId;
    private String username;


}
