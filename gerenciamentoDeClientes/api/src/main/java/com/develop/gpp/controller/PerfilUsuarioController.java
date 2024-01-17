package com.develop.gpp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.develop.gpp.domain.entity.Account;
import com.develop.gpp.domain.entity.PerfilUsuarioFuncionalidades;
import com.develop.gpp.domain.entity.dto.LoginDTO;
import com.develop.gpp.domain.service.PerfilUsuarioService;

@RestController
@RequestMapping("/perfil")
public class PerfilUsuarioController {

    @Autowired
    private final PerfilUsuarioService service = new PerfilUsuarioService();

    @GetMapping("/user")
    public Account getUser(@RequestParam String username) {
        return service.getUser(username);
    }

    @PostMapping("/vincular/{id}")
    public Account vincularPerfil(@RequestBody LoginDTO dto, @PathVariable Long id) {

        return service.vincularPerfil(dto, id);
    }

}
