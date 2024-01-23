package com.develop.gpp.domain.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.develop.gpp.domain.entity.TagsModel;

public interface TagsRepository extends JpaRepository<TagsModel, Long>{
    
}
