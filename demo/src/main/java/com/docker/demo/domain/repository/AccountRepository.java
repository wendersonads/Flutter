package com.docker.demo.domain.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.docker.demo.domain.entity.Account;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer>{

    Optional<Account> findByUsernameAndPassword(String userName, String passWord);

    Optional<Account> findByUsername(String userName);
    
}
