package com.jdevbr.parking_api.domain.entity;

import java.time.LocalDateTime;

import com.jdevbr.parking_api.domain.enums.Status;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Spot {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String plate;

    private LocalDateTime entry;

    private LocalDateTime exit;

    private Double payment;

    @Enumerated(EnumType.STRING)
    private Status status;
}
