package com.example.demo.controller;

import com.example.demo.dto.LostDTO;
import com.example.demo.services.LostService;
import com.example.demo.vo.LostQueryVO;
import com.example.demo.vo.LostUpdateVO;
import com.example.demo.vo.LostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/loses")
public class  LostController {

    @Autowired
    private LostService lostService;

    @PostMapping
    public String save(@Valid @RequestBody LostVO vO) {
        return lostService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        lostService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody LostUpdateVO vO) {
        lostService.update(id, vO);
    }

    @GetMapping("/{id}")
    public LostDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return lostService.getById(id);
    }

    @GetMapping
    public Page<LostDTO> query(@Valid LostQueryVO vO) {
        return lostService.query(vO);
    }
}
