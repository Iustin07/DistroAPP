package com.example.demo.repository;

import com.example.demo.model.Transport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TransportRepository extends JpaRepository<Transport, Long>, JpaSpecificationExecutor<Transport> {
    List<Transport> findAllByReceived( boolean received);
}