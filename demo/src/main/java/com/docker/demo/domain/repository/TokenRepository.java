package com.docker.demo.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.docker.demo.domain.entity.Token;


@Repository
public interface TokenRepository  extends JpaRepository<Token, Integer>{


}
