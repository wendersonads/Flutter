package com.docker.demo.domain.service;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.docker.demo.domain.entity.Token;
import com.docker.demo.domain.entity.dto.LoginDto;
import com.docker.demo.domain.repository.TokenRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenService {
    
    private final TokenRepository repository;

    private final AccountService service;




    public Token login(LoginDto dto) {
        
        return repository.save(dto);
    }

    
   


  
   
}
