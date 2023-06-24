package com.jdevbr.parking_api.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jdevbr.parking_api.domain.entity.Spot;
import com.jdevbr.parking_api.domain.entity.dto.SpotDTO;
import com.jdevbr.parking_api.domain.service.SpotService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("parking")
@RequiredArgsConstructor
public class ParkingController {
    
    private final SpotService service;

    @GetMapping
    public List<Spot> findALL() {
        return service.findAll();
    }

    @PostMapping
    public Spot save(@RequestBody SpotDTO dto) {
        return service.save(dto);
    }

    @PutMapping
    public Spot update(@RequestBody SpotDTO dto) {
        return service.update(dto);
    }
}
