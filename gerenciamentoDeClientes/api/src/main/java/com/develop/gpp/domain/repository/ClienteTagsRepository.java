package com.develop.gpp.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.develop.gpp.domain.entity.ClienteTagsModel;

public interface ClienteTagsRepository extends JpaRepository<ClienteTagsModel, Long> {
    
}
