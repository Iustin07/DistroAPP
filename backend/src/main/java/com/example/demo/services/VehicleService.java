package com.example.demo.services;

import com.example.demo.dto.VehicleDTO;
import com.example.demo.model.Vehicle;
import com.example.demo.repository.VehicleRepository;
import com.example.demo.vo.VehiclesQueryVO;
import com.example.demo.vo.VehiclesUpdateVO;
import com.example.demo.vo.VehiclesVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class VehicleService {

    @Autowired
    private VehicleRepository vehicleRepository;

    public String save(VehiclesVO vO) {
        Vehicle bean = new Vehicle();
        BeanUtils.copyProperties(vO, bean);
        bean = vehicleRepository.save(bean);
        return bean.getRegistrationNumber();
    }

    public void delete(String id) {
        vehicleRepository.deleteById(id);
    }

    public void update(String id, VehiclesUpdateVO vO) {
        Vehicle bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        vehicleRepository.save(bean);
    }

    public VehicleDTO getById(String id) {
        Vehicle original = requireOne(id);
        return toDTO(original);
    }

    public Page<VehicleDTO> query(VehiclesQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private VehicleDTO toDTO(Vehicle original) {
        VehicleDTO bean = new VehicleDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Vehicle requireOne(String id) {
        return vehicleRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
