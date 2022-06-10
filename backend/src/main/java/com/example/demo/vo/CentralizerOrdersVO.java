package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class CentralizerOrdersVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long centralizerId;
    private Long orderId;

}
