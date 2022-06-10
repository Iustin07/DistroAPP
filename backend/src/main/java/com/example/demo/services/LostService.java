package com.example.demo.services;

import com.example.demo.dto.LostDTO;
import com.example.demo.model.Lost;
import com.example.demo.repository.LostRepository;
import com.example.demo.vo.LostQueryVO;
import com.example.demo.vo.LostUpdateVO;
import com.example.demo.vo.LostVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class LostService {

    @Autowired
    private LostRepository lostRepository;

    public Long save(LostVO vO) {
        Lost bean = new Lost();
        BeanUtils.copyProperties(vO, bean);
        bean = lostRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        lostRepository.deleteById(id);
    }

    public void update(Long id, LostUpdateVO vO) {
        Lost bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        lostRepository.save(bean);
    }

    public LostDTO getById(Long id) {
        Lost original = requireOne(id);
        return toDTO(original);
    }

    public Page<LostDTO> query(LostQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private LostDTO toDTO(Lost original) {
        LostDTO bean = new LostDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Lost requireOne(Long id) {
        return lostRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
