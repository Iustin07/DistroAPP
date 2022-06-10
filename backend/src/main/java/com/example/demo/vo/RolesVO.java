package com.example.demo.vo;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;


@Data
public class RolesVO implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "roleId can not null")
    private Long roleId;

    @NotNull(message = "name can not null")
    private String name;

}
