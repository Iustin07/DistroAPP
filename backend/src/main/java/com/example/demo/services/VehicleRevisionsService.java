package com.example.demo.services;

import com.example.demo.dto.VehicleRevisionsDTO;
import com.example.demo.model.VehicleRevisions;
import com.example.demo.repository.VehicleRevisionsRepository;
import com.example.demo.vo.VehiclesRevisionsQueryVO;
import com.example.demo.vo.VehiclesRevisionsUpdateVO;
import com.example.demo.vo.VehiclesRevisionsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class VehicleRevisionsService {

    @Autowired
    private VehicleRevisionsRepository vehicleRevisionsRepository;

    public Long save(VehiclesRevisionsVO vO) {
        VehicleRevisions bean = new VehicleRevisions();
        BeanUtils.copyProperties(vO, bean);
        bean = vehicleRevisionsRepository.save(bean);
        return bean.getRevisionId();
    }

    public void delete(Long id) {
        vehicleRevisionsRepository.deleteById(id);
    }

    public void update(Long id, VehiclesRevisionsUpdateVO vO) {
        VehicleRevisions bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        vehicleRevisionsRepository.save(bean);
    }

    public VehicleRevisionsDTO getById(Long id) {
        VehicleRevisions original = requireOne(id);
        return toDTO(original);
    }

    public Page<VehicleRevisionsDTO> query(VehiclesRevisionsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private VehicleRevisionsDTO toDTO(VehicleRevisions original) {
        VehicleRevisionsDTO bean = new VehicleRevisionsDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private VehicleRevisions requireOne(Long id) {
        return vehicleRevisionsRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
