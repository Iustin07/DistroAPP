package com.example.demo.controller;

import com.example.demo.dto.TransportDTO;
import com.example.demo.services.TransportService;
import com.example.demo.vo.TransportQueryVO;
import com.example.demo.vo.TransportUpdateVO;
import com.example.demo.vo.TransportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("/transports")
public class TransportController {

    @Autowired
    private TransportService transportService;

    @PostMapping
    public String save(@Valid @RequestBody TransportVO vO) {
        return transportService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        transportService.delete(id);
    }

    @PatchMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody TransportUpdateVO vO) {
        transportService.update(id, vO);
    }
    @GetMapping("/all")
    public List<TransportDTO> getAllByReceived(@RequestParam("received") boolean received){
       return transportService.getAllByReceived(received);
    }
    @GetMapping("/{id}")
    public TransportDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return transportService.getById(id);
    }

    @GetMapping
    public Page<TransportDTO> query(@Valid TransportQueryVO vO) {
        return transportService.query(vO);
    }
}
