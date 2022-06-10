package com.example.demo.services;

import com.example.demo.dto.CentralizerOrdersDTO;
import com.example.demo.model.CentralizerOrders;
import com.example.demo.repository.CentralizerOrdersRepository;
import com.example.demo.vo.CentralizerOrdersQueryVO;
import com.example.demo.vo.CentralizerOrdersUpdateVO;
import com.example.demo.vo.CentralizerOrdersVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class CentralizerOrdersService {

    @Autowired
    private CentralizerOrdersRepository centralizerOrdersRepository;

    public Long save(CentralizerOrdersVO vO) {
        CentralizerOrders bean = new CentralizerOrders();
        BeanUtils.copyProperties(vO, bean);
        bean = centralizerOrdersRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        centralizerOrdersRepository.deleteById(id);
    }

    public void update(Long id, CentralizerOrdersUpdateVO vO) {
        CentralizerOrders bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        centralizerOrdersRepository.save(bean);
    }

    public CentralizerOrdersDTO getById(Long id) {
        CentralizerOrders original = requireOne(id);
        return toDTO(original);
    }

    public Page<CentralizerOrdersDTO> query(CentralizerOrdersQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private CentralizerOrdersDTO toDTO(CentralizerOrders original) {
        CentralizerOrdersDTO bean = new CentralizerOrdersDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private CentralizerOrders requireOne(Long id) {
        return centralizerOrdersRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
