package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;


@Data
public class LostVO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;

    @NotNull(message = "responsableId can not null")
    private Long responsableId;

    @NotNull(message = "productId can not null")
    private Long productId;

    private Long quantity;

    private LocalDate dateOfLost;

}
