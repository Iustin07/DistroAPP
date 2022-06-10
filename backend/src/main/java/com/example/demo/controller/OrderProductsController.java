package com.example.demo.controller;

import com.example.demo.dto.OrderProductsDTO;
import com.example.demo.services.OrderProductsService;
import com.example.demo.vo.OrderProductsQueryVO;
import com.example.demo.vo.OrderProductsUpdateVO;
import com.example.demo.vo.OrderProductsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/orderProducts")
public class OrderProductsController {

    @Autowired
    private OrderProductsService orderProductsService;

    @PostMapping
    public String save(@Valid @RequestBody OrderProductsVO vO) {
        return orderProductsService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        orderProductsService.delete(id);
    }
    @DeleteMapping("/cancel")
    public void cancelOrderItem(@NotNull @RequestParam("id")Long id){
        orderProductsService.deleteOnCanceling(id);
    }
    @DeleteMapping("/cancel/{id}")
    public void cancelItemFromOrder(@Valid @NotNull @PathVariable("id") Long id){
        orderProductsService.deleteOnCanceling(id);
    }
    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody OrderProductsUpdateVO vO) {
        orderProductsService.update(id, vO);
    }

    @GetMapping("/{id}")
    public OrderProductsDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return orderProductsService.getById(id);
    }

    @GetMapping
    public Page<OrderProductsDTO> query(@Valid OrderProductsQueryVO vO) {
        return orderProductsService.query(vO);
    }
}
