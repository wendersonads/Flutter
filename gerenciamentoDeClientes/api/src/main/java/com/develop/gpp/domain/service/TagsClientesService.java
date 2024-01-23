package com.develop.gpp.domain.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.develop.gpp.domain.entity.TagsModel;
import com.develop.gpp.domain.repository.TagsRepository;

@Service
public class TagsClientesService {
    @Autowired
    private TagsRepository repository;

    public List<TagsModel> buscarTodas() {

        return repository.findAll();
    }
}
