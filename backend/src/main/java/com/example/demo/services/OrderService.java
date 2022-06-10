package com.example.demo.services;
import com.example.demo.config.JwtTokenUtil;
import com.example.demo.dto.OrderDTO;
import com.example.demo.model.OrderProducts;
import com.example.demo.model.Order;
import com.example.demo.model.Product;
import com.example.demo.repository.CustomRepository;
import com.example.demo.repository.OrderRepository;
import com.example.demo.vo.OrdersQueryVO;
import com.example.demo.vo.OrdersUpdateVO;
import com.example.demo.vo.OrdersVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private ClientService clientService;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private ProductService productService;
    @Autowired
    private CustomRepository customRepository;
    @Transactional
    public Long save(OrdersVO vO, HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        Long agentId = jwtTokenUtil.getIdFromToken(token);

        Order bean = new Order();
        BeanUtils.copyProperties(vO, bean);
        bean.setOrderSellerAgent(agentId);
        bean.setClient(clientService.requireOne(vO.getOrderClientId()));
        for(var entry: vO.getProductsIds()){
            Product product= productService.convertToEntity(productService.getById(entry.getOpProductId()));
            OrderProducts orderProduct=new OrderProducts();
            orderProduct.setProduct(product);
            orderProduct.setProductUnits(entry.getProductUnits());
            orderProduct.setOpOrderId(vO.getOrderId());
            bean.addProduct(orderProduct);

        }
        bean = orderRepository.save(bean);
        bean.getProducts()
                .forEach(
                orderProduct-> productService.updateStockOnSell(orderProduct.getProduct().getProductId(),orderProduct.getProductUnits())
        );
        return bean.getOrderId();
    }

    public void saveBean(Order order) {

         orderRepository.save(order);

    }
    public void delete(Long id) {
        orderRepository.deleteById(id);
    }
    public void cancelOrder(Long id){
        Order order=requireOne(id);
        order.getProducts().forEach(
                orderProduct-> productService
                .updateStockOnAdding(orderProduct.getProduct().getProductId(),orderProduct.getProductUnits())
        );
        orderRepository.deleteById(id);
    }
    public void update(Long id, OrdersUpdateVO vO) {
        Order bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        orderRepository.save(bean);
    }

    public OrderDTO getById(Long id) {
        Order original = requireOne(id);
        System.out.println(original.getOrderId());
        System.out.println(original.getProducts());
        return toDTO(original);
    }

    public Page<OrderDTO> query(OrdersQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private OrderDTO toDTO(Order original) {
        OrderDTO bean = new OrderDTO();
        BeanUtils.copyProperties(original, bean);
        //bean.setProducts(original.getProducts());
        return bean;
    }

    public Order requireOne(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
    public List<OrderDTO> findByAgentAndDate(Long agentId, LocalDate date){
        List<Order> orders= orderRepository.findAllByOrderSellerAgentAndAndOrderData(agentId,date);
    return orders.stream().map(order -> toDTO(order)).collect(Collectors.toList());
    }
    public double retrieveIncome(){
        return customRepository.getIncome();
    }
}
