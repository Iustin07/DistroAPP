package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

@Data
public class LostQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long responsableId;

    private Long productId;

    private Long quantity;

    private LocalDate dateOfLost;

}
