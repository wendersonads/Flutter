package com.develop.gpp.domain.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.develop.gpp.domain.entity.ClienteModel;
import com.develop.gpp.domain.entity.ClienteTagsModel;
import com.develop.gpp.domain.entity.TagsModel;

public interface ClienteTagsRepository extends JpaRepository<ClienteTagsModel, Long> {

    Optional<ClienteTagsModel> findByClienteAndTag(ClienteModel cliente, TagsModel tag);
    
}
