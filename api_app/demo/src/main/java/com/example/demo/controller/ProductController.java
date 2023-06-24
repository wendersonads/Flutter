package com.example.demo.controller;

import com.example.demo.domain.entity.Product;
import com.example.demo.domain.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("product")
@RequiredArgsConstructor
public class ProductController {

    final ProductService service;

    @PostMapping
    public Product save(@RequestBody Product product) {
        return service.save(product);
    }

    @GetMapping
    public List<Product> findAll() {
        return service.findAll();
    }
}
