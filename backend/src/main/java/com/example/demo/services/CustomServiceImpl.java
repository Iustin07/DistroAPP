package com.example.demo.services;

import com.example.demo.model.CustomCentralizer;
import com.example.demo.repository.CustomRepository;
import org.hibernate.event.spi.SaveOrUpdateEvent;
import org.hibernate.query.internal.NativeQueryImpl;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.NamedQuery;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CustomServiceImpl implements CustomRepository {
String querySql="select p.product_name as productName, sum(op.product_units) as quantity, p.unit_measure as measureUnit  from products as p join order_products as op on p.product_id=op.op_product_id " +
        "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on co.centralizer_id=c.id where c.id=:id ) "+
        "group by op_product_id,p.product_name,p.unit_measure";
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CustomCentralizer> getSummarizeCentralizer(Long id) {
        Query query =entityManager.createNativeQuery(querySql).setParameter("id",id);
        List<CustomCentralizer> summarList=new ArrayList<>();
        List<CustomCentralizer> records=query.getResultList();
        Iterator it = records.iterator( );

        while (it.hasNext( )) {
            Object[] result = (Object[])it.next(); // Iterating through array object
            summarList.add(new CustomCentralizer(result[0].toString(),Long.parseLong(String.valueOf(result[1])),result[2].toString()));
            //userRecords.add(new CustomCentralizer(result[0], result[1], result[2]));

        }
        return  summarList;
    }

    @Override
    public double getIncome() {
        String querySql="select sum(o.order_payment_value) from orders o join centralizer_orders co on co.order_id=o.order_id where co.centralizer_id in(" +
                "select c.id from centralizers c where extract(month from c.creation_date)=extract(month from current_date))";
        Query query =entityManager.createNativeQuery(querySql);
        return new Double(query.getSingleResult().toString());
    }

    @Override
    public List<Long> topFiveProducts() {
        String querySql="select op_product_id from order_products natural join orders where extract(month from order_data)=extract(month from current_date)" +
                "group by op_product_id order by count(op_product_id) DESC limit 5;";
        Query query=entityManager.createNativeQuery(querySql);
        List<Integer> records=query.getResultList();
        System.out.println(query.getResultList());
        return  records.stream()
                .mapToLong(Integer::longValue)
                .boxed().collect(Collectors.toList());
    }
}
