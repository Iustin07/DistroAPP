package com.example.demo.vo;


import lombok.Data;

import java.io.Serializable;

@Data
public class RolesQueryVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long roleId;

    private String name;

}
