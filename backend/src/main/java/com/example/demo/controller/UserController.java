package com.example.demo.controller;

import com.example.demo.dto.CustomUser;
import com.example.demo.dto.UserDTO;
import com.example.demo.model.Password;
import com.example.demo.services.UserService;
import com.example.demo.vo.UsersQueryVO;
import com.example.demo.vo.UsersUpdateVO;
import com.example.demo.vo.UsersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@Validated
@RestController
@CrossOrigin(origins = "http://localhost:3000")
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping
    public String save(@Valid @RequestBody UsersVO vO) {
        return userService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        userService.delete(id);
    }

    @PatchMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody UsersUpdateVO vO) {
        userService.update(id, vO);
    }
    @PatchMapping("/reset")
    public ResponseEntity<Object> change(@Valid @RequestBody Password passwords, HttpServletRequest httpServletRequest){
     return userService.changePaswword(passwords,httpServletRequest);

    }
    @GetMapping("/{id}")
    public UserDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return userService.getById(id);
    }
    @GetMapping("/username")
    public UserDTO getByUsername(@Valid @NotNull @RequestParam(name = "username") String username) {
        return userService.getbyName(username);
    }
    @GetMapping("/all")
    public List<CustomUser> getAll(){
        return userService.getAllUsers();

    }
    @GetMapping("/custom")
    public List<CustomUser> getAllSpecific(@RequestParam("role") String role){

        return  userService.getAllSpecific(role);
        }
    @GetMapping("/wage")
    public double getWages(){

        return  userService.getWages();
    }
    @GetMapping
    public Page<UserDTO> query(@Valid UsersQueryVO vO) {
        return userService.query(vO);
    }
}
