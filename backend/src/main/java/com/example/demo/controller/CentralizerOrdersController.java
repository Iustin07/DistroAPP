package com.example.demo.controller;

import com.example.demo.dto.CentralizerOrdersDTO;
import com.example.demo.services.CentralizerOrdersService;
import com.example.demo.vo.CentralizerOrdersQueryVO;
import com.example.demo.vo.CentralizerOrdersUpdateVO;
import com.example.demo.vo.CentralizerOrdersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/centralizerOrders")
public class CentralizerOrdersController {

    @Autowired
    private CentralizerOrdersService centralizerOrdersService;

    @PostMapping
    public String save(@Valid @RequestBody CentralizerOrdersVO vO) {
        return centralizerOrdersService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        centralizerOrdersService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody CentralizerOrdersUpdateVO vO) {
        centralizerOrdersService.update(id, vO);
    }

    @GetMapping("/{id}")
    public CentralizerOrdersDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return centralizerOrdersService.getById(id);
    }

    @GetMapping
    public Page<CentralizerOrdersDTO> query(@Valid CentralizerOrdersQueryVO vO) {
        return centralizerOrdersService.query(vO);
    }
}
