package com.example.demo.services;

import com.example.demo.config.JwtRequestFilter;
import com.example.demo.config.JwtTokenUtil;
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

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class LostService {
    @Autowired
    private ProductService productService;
    @Autowired
    private LostRepository lostRepository;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    UserService userService;
    public Long save(LostVO vO,HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        Long userid = jwtTokenUtil.getIdFromToken(token);
        Lost bean = new Lost();
        BeanUtils.copyProperties(vO, bean);
        bean.setProduct(productService.requireOne(vO.getProductId()));
        bean.setUser(userService.requireOne(userid));
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
    public List<LostDTO> getThisMonth(HttpServletRequest httpServletRequest){
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        Long userid = jwtTokenUtil.getIdFromToken(token);
        return lostRepository.getLostsThisMonth(userid).stream().map(element->toDTO(element)).collect(Collectors.toList());

    }
    public List<LostDTO> getAllBetweenDates(String firstDate,String secondDate){
        System.out.println(firstDate+" "+secondDate);
        LocalDate firstDateAsLocalDate=LocalDate.parse(firstDate);
        LocalDate secondDateAsLocalDate=LocalDate.parse(secondDate);
        if(firstDateAsLocalDate.compareTo(secondDateAsLocalDate)>0)
        {
            LocalDate temp=firstDateAsLocalDate;
            firstDateAsLocalDate=secondDateAsLocalDate;
            secondDateAsLocalDate=temp;
        }
        System.out.println(firstDateAsLocalDate+" "+secondDateAsLocalDate);
        System.out.println(lostRepository.getLostsBetweenPeriod(firstDateAsLocalDate,secondDateAsLocalDate).stream().map(element->toDTO(element)).collect(Collectors.toList()));
        return lostRepository.getLostsBetweenPeriod(firstDateAsLocalDate,secondDateAsLocalDate).stream().map(element->toDTO(element)).collect(Collectors.toList());
    }
    public Page<LostDTO> query(LostQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private LostDTO toDTO(Lost original) {
        LostDTO bean = new LostDTO();
        BeanUtils.copyProperties(original, bean);
        bean.setProduct(productService.toDTO(original.getProduct()));
        bean.setResponsableName(original.getUser().getUsername());
        return bean;
    }

    private Lost requireOne(Long id) {
        return lostRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
