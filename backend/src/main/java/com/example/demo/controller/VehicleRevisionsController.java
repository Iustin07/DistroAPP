package com.example.demo.controller;

import com.example.demo.dto.VehicleRevisionsDTO;
import com.example.demo.services.VehicleRevisionsService;
import com.example.demo.vo.VehiclesRevisionsQueryVO;
import com.example.demo.vo.VehiclesRevisionsUpdateVO;
import com.example.demo.vo.VehiclesRevisionsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/revisions")
public class VehicleRevisionsController {

    @Autowired
    private VehicleRevisionsService vehicleRevisionsService;

    @PostMapping
    public String save(@Valid @RequestBody VehiclesRevisionsVO vO) {
        return vehicleRevisionsService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        vehicleRevisionsService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody VehiclesRevisionsUpdateVO vO) {
        vehicleRevisionsService.update(id, vO);
    }

    @GetMapping("/{id}")
    public VehicleRevisionsDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return vehicleRevisionsService.getById(id);
    }

    @GetMapping
    public Page<VehicleRevisionsDTO> query(@Valid VehiclesRevisionsQueryVO vO) {
        return vehicleRevisionsService.query(vO);
    }
}
