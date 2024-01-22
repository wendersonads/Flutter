package com.develop.gpp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.develop.gpp.domain.entity.ClienteModel;
import com.develop.gpp.domain.service.ClienteService;

@RestController
@RequestMapping("/cliente")
public class ClienteController {

    @Autowired
    ClienteService servive = new ClienteService();

    @GetMapping("/")
    public List<ClienteModel> get() {
        return servive.get();
    }
    @PostMapping("/")
    public ClienteModel salvarCli(@RequestBody ClienteModel cli) {
        return servive.salvarCli(cli);
    }
    @PutMapping("/{id}")
    public ClienteModel editarCli(@PathVariable Long id, @RequestBody ClienteModel cli) {
        return servive.editarCli(id, cli);
    }

    @DeleteMapping("/{id}")
    public void deletarCliente(@PathVariable Long id) {
        servive.deletarCliente(id);
    }

    @GetMapping("/{id}")
    public ClienteModel buscarPorId(@PathVariable Long id) {
        return servive.buscarPorId(id);
    }
}
