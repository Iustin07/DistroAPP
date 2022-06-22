package com.example.demo.services;

import com.example.demo.config.JwtTokenUtil;
import com.example.demo.dto.CentralizerDTO;
import com.example.demo.dto.CustomUser;
import com.example.demo.generator.Centroid;
import com.example.demo.generator.KMeansEngine;
import com.example.demo.model.*;
import com.example.demo.repository.CentralizerRepository;
import com.example.demo.repository.CustomRepository;
import com.example.demo.vo.CentralizersQueryVO;
import com.example.demo.vo.CentralizersUpdateVO;
import com.example.demo.vo.CentralizersVO;
import org.apache.tomcat.jni.Local;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.*;
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
    public List<CentralizerDTO> getBydate(LocalDate date){
        List<Centralizer>centralizers=centralizersRepository.findAllByCreationDate(date);
        return centralizers.stream().map(centralizer -> toDTO(centralizer)).collect(Collectors.toList());
    }
    @Transactional
    public ResponseEntity<Object> getGeneratedCentralizers(String date){
        KMeansEngine kmeans=new KMeansEngine(orderService);
        Map<Integer,Long> driverIds=new HashMap<>();
        List<CustomUser> drivers=userService.getAllSpecific("driver");
        for(int index=0;index<drivers.size();index++){
            driverIds.put(index,drivers.get(index).getUserId());
        }
        if(orderService.getAll(LocalDate.parse(date)).isEmpty()){
            return new ResponseEntity<>("There are no orders on this date",HttpStatus.NOT_FOUND);
        }
        Map<Centroid,List<KmeanOrder>> clusters=kmeans.fit(drivers.size(),date);
        int position=0;
        for(var key:clusters.keySet()){
            List<Long> orderids=clusters.get(key).stream().map(order->order.getOrderId()).collect(Collectors.toList());
            CentralizersVO centralizer=new CentralizersVO(driverIds.get(position),orderids);
            position++;
           save(centralizer);
        }
        return  new ResponseEntity<>("Centralizers generated succesfully!", HttpStatus.OK);
    }
}
