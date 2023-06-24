package com.docker.demo.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.docker.demo.domain.entity.Account;
import com.docker.demo.domain.service.AccountService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AccountController {

    private final AccountService service;

    @PostMapping("register")
    public Account registe(@RequestBody Account account){

        return service.register(account);

    }    
}
