package com.example.demo.controller;

import com.example.demo.dto.ProductDTO;
import com.example.demo.services.ProductService;
import com.example.demo.vo.ProductsQueryVO;
import com.example.demo.vo.ProductsUpdateVO;
import com.example.demo.vo.ProductsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping
    public String save(@Valid @RequestBody ProductsVO vO) {
        return productService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        productService.delete(id);
    }

    @PatchMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ProductsUpdateVO vO) {
        System.out.println(vO.toString());
        productService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ProductDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return productService.getById(id);
    }
    @GetMapping("/top")
    public List<ProductDTO> getTopFive(){
        return productService.getTopFive();
    }
    @GetMapping()
    public List<ProductDTO> getAll(){
        return  productService.getAllProducts();
    }
    public Page<ProductDTO> query(@Valid ProductsQueryVO vO) {
        return productService.query(vO);
    }
}
