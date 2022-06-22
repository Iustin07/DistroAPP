package com.example.demo.repository;

import com.example.demo.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface ClientRepository extends JpaRepository<Client, Long>, JpaSpecificationExecutor<Client> {
 //List<Client> findAllByEnabled(boolean enabled);
 List<Client> findAllByEnabledAndDeleted(boolean enabled, boolean deleted);
}