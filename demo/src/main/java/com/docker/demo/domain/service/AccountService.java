package com.docker.demo.domain.service;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.docker.demo.domain.entity.Account;
import com.docker.demo.domain.repository.AccountRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository repository;



    public Account register(Account account) {
        existsByUsername(account.getUsername());
        return repository.save(account);
    }

    private void existsByUsername(String userName) {

        if (repository.findByUsername(userName).isEmpty()) {

            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already registered!");

        }

    }

}
