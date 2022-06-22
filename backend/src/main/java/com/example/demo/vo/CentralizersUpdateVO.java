package com.example.demo.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
public class CentralizersUpdateVO extends CentralizersVO implements Serializable {
    private static final long serialVersionUID = 1L;

}
