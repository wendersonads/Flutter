package com.example.demo.domain.service;

import com.example.demo.domain.entity.Client;
import com.example.demo.domain.repository.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClientService {

    final ClientRepository repository;

    public Client save(Client client) {
        return repository.save(client);
    }

    public List<Client> findAll() {
        return repository.findAll();
    }
}
