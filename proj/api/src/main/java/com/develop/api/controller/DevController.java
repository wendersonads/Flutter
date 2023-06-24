package com.develop.api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
@RequestMapping("dev")
public class DevController {

    @GetMapping
    public String getValue() {
        return LocalDateTime.now().toString();
    }
}
