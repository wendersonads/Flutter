package com.develop.dev_api.domain.entity.dto;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class DevDTO {

    private String name;

    private Double total;

    private LocalDateTime date;
}
