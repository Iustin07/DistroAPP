package com.example.demo.controller;

import com.example.demo.dto.OrderDTO;
import com.example.demo.services.OrderService;
import com.example.demo.vo.OrdersQueryVO;
import com.example.demo.vo.OrdersUpdateVO;
import com.example.demo.vo.OrdersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Validated
@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping
    public String save(@Valid @RequestBody OrdersVO vO, HttpServletRequest httpServletRequest) {
        return orderService.save(vO,httpServletRequest).toString();
    }
    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        orderService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody OrdersUpdateVO vO) {
        orderService.update(id, vO);
    }
    @DeleteMapping("/cancel")
    public void cancelOrder(@NotNull @RequestParam("id")Long id){
        orderService.cancelOrder(id);
    }
    @GetMapping("/{id}")
    public OrderDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return orderService.getById(id);
    }
    @GetMapping("/")
    public List<OrderDTO> getByAgentAndDate(@RequestParam Long agentId, @RequestParam String date){
        LocalDate localDate = LocalDate.parse(date);
        return orderService.findByAgentAndDate(agentId,localDate);
    }
    @GetMapping("/income")
    public double getIncome(){
        return orderService.retrieveIncome();
    }
    @GetMapping("/anual")
    public Map<String, Double> getAnualStats(){
        return orderService.anulStats();
    }
    @GetMapping
    public Page<OrderDTO> query(@Valid OrdersQueryVO vO) {
        return orderService.query(vO);
    }
}
