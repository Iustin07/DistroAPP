package com.example.demo.controller;

import com.example.demo.dto.VehicleDTO;
import com.example.demo.services.VehicleService;
import com.example.demo.vo.VehiclesQueryVO;
import com.example.demo.vo.VehiclesUpdateVO;
import com.example.demo.vo.VehiclesVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/vehicles")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @PostMapping
    public String save(@Valid @RequestBody VehiclesVO vO) {
        return vehicleService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") String id) {
        vehicleService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") String id,
                       @Valid @RequestBody VehiclesUpdateVO vO) {
        vehicleService.update(id, vO);
    }

    @GetMapping("/{id}")
    public VehicleDTO getById(@Valid @NotNull @PathVariable("id") String id) {
        return vehicleService.getById(id);
    }

    @GetMapping
    public Page<VehicleDTO> query(@Valid VehiclesQueryVO vO) {
        return vehicleService.query(vO);
    }
}
