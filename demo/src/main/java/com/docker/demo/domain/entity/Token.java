package com.docker.demo.domain.entity;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;


@Data
@Entity
public class Token {

@Id
@JsonIgnore
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Integer id;

private String token;

@JsonIgnore
private LocalDateTime valid;

    
}
