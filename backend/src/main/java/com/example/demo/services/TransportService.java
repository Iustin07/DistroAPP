package com.example.demo.services;

import com.example.demo.dto.TransportDTO;
import com.example.demo.model.Product;
import com.example.demo.model.ProductShipping;
import com.example.demo.model.Review;
import com.example.demo.model.Transport;
import com.example.demo.repository.TransportRepository;
import com.example.demo.utils.CustomCopy;
import com.example.demo.vo.ProductsUpdateVO;
import com.example.demo.vo.TransportQueryVO;
import com.example.demo.vo.TransportUpdateVO;
import com.example.demo.vo.TransportVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class TransportService {

    @Autowired
    private TransportRepository transportRepository;
    @Autowired
    private ProductService productService;
    public Long save(TransportVO vO) {
        Transport bean = new Transport();
        BeanUtils.copyProperties(vO, bean);
        bean = transportRepository.save(bean);
        return bean.getIdTransport();
    }

    public void delete(Long id) {
        transportRepository.deleteById(id);
    }
@Transactional
    public void update(Long id, TransportUpdateVO vO) {
        Transport bean = requireOne(id);
        //BeanUtils.copyProperties(vO, bean);
        CustomCopy.myCopyProperties(vO,bean);
        if(vO.getReview()!=null){
            Review review=new  Review();
            BeanUtils.copyProperties(vO.getReview(),review);
            review.setTransportId(id);
            bean.setReview(review);
        }
        if(!vO.getProducts().isEmpty()){
            for(var shProduct:vO.getProducts()){
                ProductShipping productShipping=new ProductShipping();
                Product product=productService.requireOne(shProduct.getPsProductId());
                BeanUtils.copyProperties(shProduct,productShipping);
                productShipping.setProduct(product);
                productShipping.setPsIdTransport(id);
                bean.addShippingProduct(productShipping);

                ProductsUpdateVO update=new ProductsUpdateVO();
                update.setStock(ProductShippingService.convertUnits(shProduct.getProductQuantity(),product, shProduct.getUnityMeasure())+product.getStock());
                productService.update(product.getProductId(),update);
            }
        }
        bean.setReceived(true);
        transportRepository.save(bean);
    }

    public TransportDTO getById(Long id) {
        Transport original = requireOne(id);
        return toDTO(original);
    }

    public List<TransportDTO> getAllByReceived(boolean received){
        return transportRepository.findAllByReceived(received).stream()
                .map(element->toDTO(element)).collect(Collectors.toList());
    }

    public Page<TransportDTO> query(TransportQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private TransportDTO toDTO(Transport original) {
        TransportDTO bean = new TransportDTO();
        BeanUtils.copyProperties(original, bean);

        return bean;
    }

    private Transport requireOne(Long id) {
        return transportRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
