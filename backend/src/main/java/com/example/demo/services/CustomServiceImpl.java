package com.example.demo.services;

import com.example.demo.model.CustomCentralizer;
import com.example.demo.model.DividerObject;

import com.example.demo.repository.CustomRepository;

import org.modelmapper.internal.Pair;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;

import javax.persistence.PersistenceContext;
import javax.persistence.Query;
;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class CustomServiceImpl implements CustomRepository {
    @PersistenceContext
    private EntityManager entityManager;
String querySql="select p.product_name, sum(op.product_units) as quantity,p.units_per_box," +
        "units_per_pallet,p.unit_measure  " +
        "from products as p join order_products as op on p.product_id=op.op_product_id " +
        "where op.op_order_id in ( select co.order_id from centralizers as c join centralizer_orders as co on " +
        "co.centralizer_id=c.id where c.id=:id ) "+
        "group by op_product_id,p.product_name,p.units_per_box,p.units_per_pallet,p.unit_measure";
    @Override
    public List<CustomCentralizer> getSummarizeCentralizer(Long id) {
        Query query =entityManager.createNativeQuery(querySql).setParameter("id",id);
        List<CustomCentralizer> summarList=new ArrayList<>();
        List<CustomCentralizer> records=query.getResultList();
        Iterator it = records.iterator( );
        while (it.hasNext( )) {
            Object[] result = (Object[])it.next();
            String productName=String.valueOf(result[0]);
            int sumQuantity=Integer.parseInt(String.valueOf(result[1]));
            int unitsPerPallet=Integer.parseInt(String.valueOf(result[2]));
            int unitsPerBox=Integer.parseInt(String.valueOf(result[3]));
            String unitMeasure=String.valueOf(result[4]);
            // Iterating through array object
            summarList.add(new CustomCentralizer(
                    productName,
                    calculateDivider(sumQuantity,unitsPerBox,unitsPerPallet,unitMeasure)
            ));
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

    @Override
    public Map<String, Double> getAnulStats() {
        String querySql="select to_char(date_trunc('month',order_data),'month'), sum(order_payment_value) from  orders  " +
                "where extract(year from order_data)=extract(year from current_date) group by 1;";
        Map<String, Double> mapAnualStats = Stream.of(new String[]{
                "january", "february","march","april","may","june","july","august","september","october","november","december"
        }).collect(Collectors.toMap(data -> data, data ->new Double(0)));
        Query query=entityManager.createNativeQuery(querySql);
        List<Pair<String,Integer>> records=query.getResultList();
        Iterator it = records.iterator( );
        while (it.hasNext( )) {
            Object[] result = (Object[])it.next();
            String month=String.valueOf(result[0]);
            double value=Double.parseDouble(String.valueOf(result[1]));
            mapAnualStats.put(month.trim(),value);
        }

    return  new TreeMap<String, Double>(mapAnualStats);
    }

    private DividerObject calculateDivider(int quantity,int unitsPerPallet,int unitsPerBox, String unitMeasure){
        int palletResume=0;
        int boxResume=0;
        switch(unitMeasure){
            case "Buc":
                if(quantity>=unitsPerPallet){
                    palletResume=quantity/unitsPerPallet;
                quantity-=palletResume*unitsPerPallet;
                }
                if(quantity>=unitsPerBox){
                    boxResume=quantity/unitsPerBox;
                    quantity-=boxResume*unitsPerBox;
                }
                if(quantity<0)
                    quantity=0;
                return  new DividerObject(palletResume,boxResume,quantity);
            case "Box":
                quantity=quantity*unitsPerBox;
                if(quantity>=unitsPerPallet){
                    palletResume=quantity/unitsPerPallet;
                    quantity-=palletResume*unitsPerPallet;
                }
                if(quantity>=unitsPerBox){
                    boxResume=quantity/unitsPerBox;
                    quantity-=boxResume*unitsPerBox;
                }
                if(quantity<0)
                    quantity=0;
                return  new DividerObject(palletResume,boxResume,quantity);
        }
        return new DividerObject(0,0,0);
    }
}
