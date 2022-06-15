package com.example.demo.services;

import com.example.demo.dto.ProductShippingDTO;
import com.example.demo.model.Product;
import com.example.demo.model.ProductShipping;
import com.example.demo.repository.ProductShippingRepository;
import com.example.demo.vo.ProductShippingQueryVO;
import com.example.demo.vo.ProductShippingUpdateVO;
import com.example.demo.vo.ProductShippingVO;
import com.example.demo.vo.ProductsUpdateVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class ProductShippingService {
@Autowired
private ProductService productService;
    @Autowired
    private ProductShippingRepository productShippingRepository;

    public Long save(ProductShippingVO vO) {
        ProductShipping bean = new ProductShipping();
        BeanUtils.copyProperties(vO, bean);
        Product product=productService.requireOne(vO.getPsProductId());
        bean = productShippingRepository.save(bean);
        ProductsUpdateVO update=new ProductsUpdateVO();
        update.setStock(convertUnits(vO.getProductQuantity(),product,vO.getUnityMeasure()));
        productService.update(product.getProductId(),update);
        return bean.getPsId();

    }

    public void delete(Long id) {
        productShippingRepository.deleteById(id);
    }

    public void update(Long id, ProductShippingUpdateVO vO) {
        ProductShipping bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        productShippingRepository.save(bean);
    }

    public ProductShippingDTO getById(Long id) {
        ProductShipping original = requireOne(id);
        return toDTO(original);
    }

    public Page<ProductShippingDTO> query(ProductShippingQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private ProductShippingDTO toDTO(ProductShipping original) {
        ProductShippingDTO bean = new ProductShippingDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private ProductShipping requireOne(Long id) {
        return productShippingRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
    static double convertUnits(double quantity,Product product,String VoUnitMeasure){
        String prodUnitMeasure=product.getUnitMeasure();
        switch (VoUnitMeasure){
            case "Pal":
                if(prodUnitMeasure.equals("Buc"))
                    return  quantity*product.getUnitsPerPallet();
                else if(product.equals("Box"))
                    return  quantity*product.getUnitsPerPallet()/product.getUnitsPerBox();
                break;
            case "Box":
                if(prodUnitMeasure.equals("Box"))
                    return  quantity;
                if(prodUnitMeasure.equals("Buc"))
                    return quantity*product.getUnitsPerBox();
            case "Buc":
                if(prodUnitMeasure.equals("Box"))
                    return  quantity/product.getUnitsPerBox();
                if(prodUnitMeasure.equals("Buc"))
                    return quantity;
        }
        return 0;
    }
}
