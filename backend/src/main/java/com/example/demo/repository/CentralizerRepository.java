package com.example.demo.repository;

import com.example.demo.dto.CentralizerDTO;
import com.example.demo.model.Centralizer;
import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.LocalDate;
import java.util.List;

public interface CentralizerRepository extends JpaRepository<Centralizer, Long>, JpaSpecificationExecutor<Centralizer> {

    List<Centralizer> findAllByCreationDateAndDeliverDriver(LocalDate date, Long driverId);
    List<Centralizer> findAllByCreationDate(LocalDate date);
}