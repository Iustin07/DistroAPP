package com.example.demo.services;

import com.example.demo.dto.RoleDTO;
import com.example.demo.model.Role;
import com.example.demo.repository.RoleRepository;
import com.example.demo.vo.RolesQueryVO;
import com.example.demo.vo.RolesUpdateVO;
import com.example.demo.vo.RolesVO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class RoleService {

    @Autowired
    private RoleRepository roleRepository;

    public Long save(RolesVO vO) {
        Role bean = new Role();
        BeanUtils.copyProperties(vO, bean);
        bean = roleRepository.save(bean);
        return bean.getRoleId();
    }

    public void delete(Long id) {
        roleRepository.deleteById(id);
    }

    public void update(Long id, RolesUpdateVO vO) {
        Role bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        roleRepository.save(bean);
    }

    public RoleDTO getById(Long id) {
        Role original = requireOne(id);
        return toDTO(original);
    }
    public RoleDTO getByName(String roleName) {
        Role original = roleRepository.findByName(roleName);
        return toDTO(original);
    }
    public Page<RoleDTO> query(RolesQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private RoleDTO toDTO(Role original) {
        RoleDTO bean = new RoleDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Role requireOne(Long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
    public Role convertToEntity(RoleDTO roleDto){
        Role role = new ModelMapper().map(roleDto, Role.class);
        return role;
    }
}
