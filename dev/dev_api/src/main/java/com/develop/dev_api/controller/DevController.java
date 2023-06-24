package com.develop.dev_api.controller;

import com.develop.dev_api.domain.entity.Dev;
import com.develop.dev_api.domain.entity.dto.DevDTO;
import com.develop.dev_api.domain.service.DevService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("dev")
@RequiredArgsConstructor
public class DevController {

    private final DevService service;

    @GetMapping
    public List<Dev> findAll() {
        return service.findAll();
    }

    @GetMapping("enabled")
    public List<Dev> findAllEnabled() {
        return service.findAllEnabled();
    }

    @PostMapping
    public Dev save(@RequestBody DevDTO devDTO) {
        return service.save(devDTO);
    }
}
