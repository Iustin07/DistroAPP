package com.example.demo.vo;

import com.example.demo.model.CentralizerOrders;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Data
public class CentralizersVO implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private LocalDate creationDate;
    @NotNull(message = "deliverDriver can not null")
    private Long deliverDriver;
    private List<Long> ordersIds=new ArrayList<>();
}
