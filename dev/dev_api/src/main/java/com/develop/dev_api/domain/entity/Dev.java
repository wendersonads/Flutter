package com.develop.dev_api.domain.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Entity
public class Dev {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Double total;

    private LocalDateTime date;

    private UUID uuid;

    private Boolean enabled;
}
