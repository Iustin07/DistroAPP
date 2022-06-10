package com.example.demo.controller;

import com.example.demo.dto.RoleDTO;
import com.example.demo.services.RoleService;
import com.example.demo.vo.RolesQueryVO;
import com.example.demo.vo.RolesUpdateVO;
import com.example.demo.vo.RolesVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/roles")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @PostMapping
    public String save(@Valid @RequestBody RolesVO vO) {
        return roleService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        roleService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody RolesUpdateVO vO) {
        roleService.update(id, vO);
    }

    @GetMapping("/{id}")
    public RoleDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return roleService.getById(id);
    }

    @GetMapping
    public Page<RoleDTO> query(@Valid RolesQueryVO vO) {
        return roleService.query(vO);
    }
}
