package com.example.demo.controller;

import com.example.demo.dto.ProductShippingDTO;
import com.example.demo.services.ProductShippingService;
import com.example.demo.vo.ProductShippingQueryVO;
import com.example.demo.vo.ProductShippingUpdateVO;
import com.example.demo.vo.ProductShippingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/productsShipping")
public class ProductsShippingController {

    @Autowired
    private ProductShippingService productShippingService;

    @PostMapping
    public String save(@Valid @RequestBody ProductShippingVO vO) {
        return productShippingService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        productShippingService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ProductShippingUpdateVO vO) {
        productShippingService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ProductShippingDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return productShippingService.getById(id);
    }

    @GetMapping
    public Page<ProductShippingDTO> query(@Valid ProductShippingQueryVO vO) {
        return productShippingService.query(vO);
    }
}
