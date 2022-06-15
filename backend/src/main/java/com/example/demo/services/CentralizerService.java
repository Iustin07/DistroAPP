package com.example.demo.services;

import com.example.demo.config.JwtTokenUtil;
import com.example.demo.dto.CentralizerDTO;
import com.example.demo.model.CentralizerOrders;
import com.example.demo.model.Centralizer;
import com.example.demo.model.CustomCentralizer;
import com.example.demo.model.User;
import com.example.demo.repository.CentralizerRepository;
import com.example.demo.repository.CustomRepository;
import com.example.demo.vo.CentralizersQueryVO;
import com.example.demo.vo.CentralizersUpdateVO;
import com.example.demo.vo.CentralizersVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class CentralizerService {
    @Autowired
    private OrderService orderService;
    @Autowired
    private CentralizerRepository centralizersRepository;
    @Autowired
    private CustomRepository customRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Transactional
    public Long save(CentralizersVO vO) {
        Centralizer bean = new Centralizer();
        BeanUtils.copyProperties(vO, bean);
        //bean.setDriver(userService.requireOne(vO.getDeliverDriver()));
        for (Long orderId : vO.getOrdersIds()) {
            bean.addOrder(new CentralizerOrders().setOrder(orderService.requireOne(orderId)));
        }
        bean = centralizersRepository.save(bean);
        return bean.getId();
    }

    public void delete(Long id) {
        centralizersRepository.deleteById(id);
    }

    public void update(Long id, CentralizersUpdateVO vO) {
        Centralizer bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        centralizersRepository.save(bean);
    }

    public CentralizerDTO getById(Long id) {
        Centralizer original = requireOne(id);
        return toDTO(original);
    }
    public List<CentralizerDTO> getAll(){
        List<Centralizer>centralizers=centralizersRepository.findAll();
        return centralizers.stream().map(centralizer -> toDTO(centralizer)).collect(Collectors.toList());
    }

    public  List<CustomCentralizer> getSummarize(Long id){
        return customRepository.getSummarizeCentralizer(id);
    }
    public List<CentralizerDTO> query(CentralizersQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private CentralizerDTO toDTO(Centralizer original) {
        CentralizerDTO bean = new CentralizerDTO();
        BeanUtils.copyProperties(original, bean);
        //bean.setDriverName(original.getDriver().getUsername());
        bean.setDriverName(userService.requireOne(original.getDeliverDriver()).getUsername());
        return bean;
    }

    private Centralizer requireOne(Long id) {
        return centralizersRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }

    public List<CentralizerDTO> getByDateAndDriver(String date, HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        String userRole = jwtTokenUtil.getRoleFromToken(token);
        if(userRole.equals("driver")){
                Long driverId=jwtTokenUtil.getIdFromToken(token);
               return centralizersRepository.findAllByCreationDateAndDeliverDriver(LocalDate.parse(date),driverId)
                       .stream().map(centralizer->toDTO(centralizer)).collect(Collectors.toList());
        }
        return new ArrayList<>();
    }
}
