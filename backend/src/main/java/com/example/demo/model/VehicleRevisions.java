package com.example.demo.model;

import lombok.Data;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Data
@Entity
@Accessors(chain = true)
@Table(name = "vehicles_revisions")
public class VehicleRevisions implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "revision_id", nullable = false)
    private Long revisionId;
    @ManyToOne
    @JoinColumn(name="rev_registration_number", nullable=false)
    private Vehicle vehicle;

    @Column(name = "revision_date", nullable = false)
    private LocalDate revisionDate;

    @Column(name = "revision_cost", nullable = false)
    private Float revisionCost;

}
