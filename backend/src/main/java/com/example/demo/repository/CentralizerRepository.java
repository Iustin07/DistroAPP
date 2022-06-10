package com.example.demo.repository;

import com.example.demo.model.Centralizer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface CentralizerRepository extends JpaRepository<Centralizer, Long>, JpaSpecificationExecutor<Centralizer> {
//    @Query(value = "select new CustomCentralizer(p.product_name as productName, sum(op.product_units) as quantity, p.unit_measure as measureUnit)  from products as p join order_products as op on p.product_id=op.op_product_id \n" +
//                    "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on co.centralizer_id=c.id where c.id=:id ) \n"+
//                    "group by op_product_id,p.product_name,p.unit_measure",
//    countQuery = "select count(*)  from products as p join order_products as op on p.product_id=op.op_product_id \n" +
//            "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on co.centralizer_id=c.id where c.id=:id ) \n"+
//            "group by op_product_id,p.product_name,p.unit_measure",
//            nativeQuery = true
//    )
//    @SqlResultSetMapping(
//            name="SummarizeMapping",
//            classes = @ConstructorResult(
//            targetClass = CustomCentralizer.class,
//            columns = {
//                    @ColumnResult(name="productName"),
//                    @ColumnResult(name="quntity",type=Long.class),
//                    @ColumnResult(name="measureUnit")
//            }
//    ))
//    List<CustomCentralizer> getSummarizeCentralizer(@Param("id") Long id);
}