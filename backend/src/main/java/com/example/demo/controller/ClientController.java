package com.example.demo.controller;

import com.example.demo.dto.ClientDTO;
import com.example.demo.services.ClientService;
import com.example.demo.vo.ClientsQueryVO;
import com.example.demo.vo.ClientsUpdateVO;
import com.example.demo.vo.ClientsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientService clientService;

    @PostMapping
    public String save(@Valid @RequestBody ClientsVO vO, HttpServletRequest httpServletRequest) {
        System.out.println("save controller clients called ");
        return clientService.save(vO, httpServletRequest).toString();
    }
    @GetMapping("/all")
    public List<ClientDTO> getAll(){
    return clientService.getAll();}
    @GetMapping("/")
    public List<ClientDTO> getAllEnabled(@RequestParam("enabled") boolean enabled){
        return clientService.getAllEnabled(enabled);}
    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        clientService.delete(id);
    }
    @PatchMapping("/")
    public void enableClient(@RequestParam("id") Long id){
    clientService.updateEnable(id);
    }
    @PatchMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ClientsUpdateVO vO) {
        clientService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ClientDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return clientService.getById(id);
    }

    @GetMapping
    public Page<ClientDTO> query(@Valid ClientsQueryVO vO) {
        return clientService.query(vO);
    }
}
