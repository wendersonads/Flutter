package com.docker.demo.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.docker.demo.domain.entity.Token;
import com.docker.demo.domain.entity.dto.LoginDto;
import com.docker.demo.domain.service.TokenService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class LoginController {

    private TokenService service;


    @PostMapping("login")
    public Token login(@RequestBody LoginDto dto){
    
    return service.login(dto);


    }
    
}
