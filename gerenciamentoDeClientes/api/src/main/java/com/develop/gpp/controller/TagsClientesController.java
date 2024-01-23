package com.develop.gpp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.develop.gpp.domain.entity.TagsModel;
import com.develop.gpp.domain.service.TagsClientesService;


@RestController
@RequestMapping("/tags")
public class TagsClientesController {
    @Autowired
    private TagsClientesService service;

    @GetMapping("/")
    public List<TagsModel> buscarTodas(){

        return service.buscarTodas();

    }
}
