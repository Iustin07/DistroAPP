package com.example.demo.services;

import com.example.demo.dto.OrderProductsDTO;
import com.example.demo.model.OrderProducts;
import com.example.demo.model.Order;
import com.example.demo.model.Product;
import com.example.demo.repository.OrderProductsRepository;
import com.example.demo.vo.OrderProductsQueryVO;
import com.example.demo.vo.OrderProductsUpdateVO;
import com.example.demo.vo.OrderProductsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.NoSuchElementException;

@Service
public class OrderProductsService {
    @Autowired
    private ProductService productService;
    @Autowired
    private OrderProductsRepository orderProductsRepository;
@Autowired
private OrderService orderService;
    public Long save(OrderProductsVO vO) {
        OrderProducts bean = new OrderProducts();
        BeanUtils.copyProperties(vO, bean);
        bean = orderProductsRepository.save(bean);
        return bean.getOpId();
    }

    public void delete(Long id) {
        orderProductsRepository.deleteById(id);
    }
    @Transactional
    public void deleteOnCanceling(Long id){
        System.out.println("delete on cancel");
        OrderProducts orderProduct=requireOne(id);
        Product product=orderProduct.getProduct();
        orderProductsRepository.deleteById(id);
        productService.updateStockOnAdding(orderProduct.getProduct().getProductId(),orderProduct.getProductUnits());
        Order order= orderService.requireOne(orderProduct.getOpOrderId());
        order.setOrderPaymentValue(
                order.getOrderPaymentValue()-(productService.getPriceByUm(product)*orderProduct.getProductUnits())
        );
        System.out.println("new value  for total new payment "+ productService.getPriceByUm(product)*orderProduct.getProductUnits());
        order.setTotalWeight(order.getTotalWeight()-(product.getWeight()*orderProduct.getProductUnits()));
        System.out.println("new value for total weight "+ (order.getTotalWeight()-product.getWeight()*orderProduct.getProductUnits()));
        orderService.saveBean(order);

    }
    public void update(Long id, OrderProductsUpdateVO vO) {
        OrderProducts bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        orderProductsRepository.save(bean);
    }

    public OrderProductsDTO getById(Long id) {
        OrderProducts original = requireOne(id);
        return toDTO(original);
    }

    public Page<OrderProductsDTO> query(OrderProductsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private OrderProductsDTO toDTO(OrderProducts original) {
        OrderProductsDTO bean = new OrderProductsDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private OrderProducts requireOne(Long id) {
        return orderProductsRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
