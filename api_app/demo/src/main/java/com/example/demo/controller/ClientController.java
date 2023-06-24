package com.example.demo.controller;

import com.example.demo.domain.entity.Client;
import com.example.demo.domain.service.ClientService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("client")
@RequiredArgsConstructor
public class ClientController {

    final ClientService service;

    @PostMapping
    public Client save(@RequestBody Client client) {
        return service.save(client);
    }

    @GetMapping
    public List<Client> findAll() {
        return service.findAll();
    }
}
