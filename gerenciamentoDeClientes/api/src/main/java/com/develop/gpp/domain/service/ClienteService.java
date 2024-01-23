package com.develop.gpp.domain.service;

import java.util.ArrayList;
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
import com.develop.gpp.domain.entity.ClienteTagsModel;
import com.develop.gpp.domain.repository.ClienteRepository;
import com.develop.gpp.domain.repository.ClienteTagsRepository;

@Service
public class ClienteService {

	@Autowired
	private ClienteRepository clienteRepository;

	@Autowired
	private ClienteTagsRepository cliTagRepository;

	public List<ClienteModel> get() {
		return clienteRepository.findAll();
	}

	public ClienteModel salvarCli(@RequestBody ClienteModel cli) {
		ClienteModel novoCli = clienteRepository.save(cli);

		ClienteModel cliBanco = clienteRepository.findById(novoCli.getIdCliente()).get();

		if (cli.getClienteTags() != null) {
			List<ClienteTagsModel> clienteTagsList = new ArrayList<>();

			for (ClienteTagsModel cliTags : cli.getClienteTags()) {
				if (!cliTagRepository.findByClienteAndTag(cliBanco, cliTags.getTag()).isPresent()) {
					ClienteTagsModel novo = new ClienteTagsModel();
					novo.setCliente(cliBanco);
					novo.setTag(cliTags.getTag());

					clienteTagsList.add(novo);
				}
			}

			cliTagRepository.saveAll(clienteTagsList);
		}

		return novoCli;
	}

	public ClienteModel editarCli(Long id, ClienteModel cli) {

		ClienteModel cliBanco = clienteRepository.findById(id).get();

		if (cliBanco == null) {

			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cliente não localizado!");

		}

		cliBanco.setNome(cli.getNome());
		cliBanco.setEmail(cli.getEmail());

		if (cli.getClienteTags() != null) {
			List<ClienteTagsModel> clienteTagsList = new ArrayList<>();

			for (ClienteTagsModel cliTags : cli.getClienteTags()) {
				if (!cliTagRepository.findByClienteAndTag(cliBanco, cliTags.getTag()).isPresent()) {
					ClienteTagsModel novo = new ClienteTagsModel();
					novo.setCliente(cliBanco);
					novo.setTag(cliTags.getTag());

					clienteTagsList.add(novo);
				}
			}

			cliTagRepository.saveAll(clienteTagsList);
		}

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
