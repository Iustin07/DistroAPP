package com.example.demo.services;

import com.example.demo.dto.ProductDTO;
import com.example.demo.model.Product;
import com.example.demo.repository.CustomRepository;
import com.example.demo.repository.ProductRepository;
import com.example.demo.utils.CustomCopy;
import com.example.demo.vo.ProductsQueryVO;
import com.example.demo.vo.ProductsUpdateVO;
import com.example.demo.vo.ProductsVO;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CustomRepository customRepository;
    public Long save(ProductsVO vO) {

        Product bean = new Product();
        BeanUtils.copyProperties(vO, bean);
        bean = productRepository.save(bean);
        return bean.getProductId();
    }

    public void delete(Long id) {
        productRepository.deleteById(id);
    }

    public void update(Long id, ProductsUpdateVO vO) {
        Product bean = requireOne(id);
        vO.setProductId(null);
        CustomCopy.myCopyProperties(vO,bean);
        //BeanUtils.copyProperties(vO, bean);
        productRepository.save(bean);
    }
    public void updateStockOnSell(Long id, double selledUnits){
        Product bean = requireOne(id);
        double oldStock=bean.getStock();
        bean.setStock(oldStock-selledUnits);
        productRepository.save(bean);
    }
    public void updateStockOnAdding(Long id,double numberUnits){
        Product bean = requireOne(id);
        double oldStock=bean.getStock();
        bean.setStock(oldStock+numberUnits);
        productRepository.save(bean);

    }
    public ProductDTO getById(Long id) {
        Product original = requireOne(id);
        return toDTO(original);
    }

    public Page<ProductDTO> query(ProductsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    public ProductDTO toDTO(Product original) {
        ProductDTO bean = new ProductDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }
    public List<ProductDTO> getTopFive(){
        return customRepository.topFiveProducts().stream().map(id->toDTO(requireOne(id))).collect(Collectors.toList());
    }
    public Product requireOne(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
    public Product convertToEntity(ProductDTO productDto){
        Product product = new ModelMapper().map(productDto, Product.class);
        return product;
    }
    public List<ProductDTO> getAllProducts(){
        return productRepository.findAll().stream().map(element->toDTO(element)).collect(Collectors.toList());
    }
    public double getPriceByUm(Product product){
        switch (product.getUnitMeasure()){
            case "Box":
                return product.getPricePerBox();
            case "Nav":
                return  product.getPricePerBox();
            case "Buc":
                return  product.getPricePerUnit();
            case "Pal":
                return  product.getPricePerPallet();
            default:
                return 0;
        }
    }
}
