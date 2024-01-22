package com.develop.gpp.domain.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.develop.gpp.domain.entity.ClienteModel;
import com.develop.gpp.domain.repository.ClienteRepository;


@Service
public class ClienteService {

	@Autowired
	private ClienteRepository clienteRepository;

	public List<ClienteModel> get() {
		return clienteRepository.findAll();
	}

	public ClienteModel salvarCli(@RequestBody ClienteModel cli) {

		return clienteRepository.save(cli);

	}

	public ClienteModel editarCli(Long id, ClienteModel cli) {

		ClienteModel cliBanco = clienteRepository.findById(id).get();

		if (cliBanco == null) {

			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cliente não localizado!");

		}
		cliBanco.setNome(cli.getNome());
		cliBanco.setEmail(cli.getEmail());

		ClienteModel clienteAtualizado = clienteRepository.save(cliBanco);

		return clienteAtualizado;
	}

	public void deletarCliente(Long id) {
       
        if (!clienteRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cliente não localizado!");
        }

        clienteRepository.deleteById(id);
    }

	public ClienteModel buscarPorId(Long id) {
      
        return clienteRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Cliente não encontrado"));
    }

}
