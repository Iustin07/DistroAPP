package com.example.demo.repository;

import com.example.demo.model.VehicleRevisions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface VehicleRevisionsRepository extends JpaRepository<VehicleRevisions, Long>, JpaSpecificationExecutor<VehicleRevisions> {

}