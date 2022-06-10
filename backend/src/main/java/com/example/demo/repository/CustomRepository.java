package com.example.demo.repository;

import com.example.demo.model.CustomCentralizer;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CustomRepository {
//    @Query(value = "select new CustomCentralizer(p.product_name as productName, sum(op.product_units) as quantity, p.unit_measure as measureUnit)  from products as p join order_products as op on p.product_id=op.op_product_id \n" +
//            "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on co.centralizer_id=c.id where c.id=:id ) \n"+
//            "group by op_product_id,p.product_name,p.unit_measure",
//            countQuery = "select count(*)  from products as p join order_products as op on p.product_id=op.op_product_id \n" +
//                    "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on co.centralizer_id=c.id where c.id=:id ) \n"+
//                    "group by op_product_id,p.product_name,p.unit_measure",
//            nativeQuery = true
//    )
    List<CustomCentralizer> getSummarizeCentralizer(Long id);
    double getIncome();
    List<Long> topFiveProducts();
}
