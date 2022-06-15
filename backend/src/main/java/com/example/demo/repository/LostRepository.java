package com.example.demo.repository;

import com.example.demo.dto.LostDTO;
import com.example.demo.model.Lost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface LostRepository extends JpaRepository<Lost, Long>, JpaSpecificationExecutor<Lost> {
@Query(value = "select * from loses  where responsable_id=:userId and extract(month from date_of_lost)=extract(month from current_date)",
        nativeQuery = true)
List<Lost> getLostsThisMonth(@Param("userId") Long userId);

@Query(value="select * from loses where date_of_lost between :firstDate and :secondDate",
nativeQuery = true)
    List<Lost> getLostsBetweenPeriod(@Param("firstDate") LocalDate firstDate, @Param("secondDate")LocalDate secondDate);

}