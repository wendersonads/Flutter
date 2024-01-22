import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/repository/cliente_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/Notificacao.dart';

class ClienteDetalheService extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int id;
  TextEditingController nomeCliente = TextEditingController();
  TextEditingController emailCliente = TextEditingController();
  late Rx<ClienteModel> cliente;
  late ClienteRepository repository;
  var carregandoCliente = false.obs;

  ClienteDetalheService(Id) {
    id = Id;
    cliente = ClienteModel().obs;
    repository = ClienteRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    await buscarPorId();
  }

  Future<void> buscarPorId() async {
    try {
      carregandoCliente(true);
      cliente.value = await repository.buscarPorId(id);
      if (cliente.value != null) {
        nomeCliente.text = cliente.value.nome!.toString();
        emailCliente.text = cliente.value.email!.toString();
      }
    } catch (e) {
      carregandoCliente(true);
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    } finally {
      carregandoCliente(false);
    }
  }

  Future<bool> editarCliente() async {
    late bool retorno;
    try {
      cliente.value.nome = nomeCliente.text.toString();
      cliente.value.email = emailCliente.text.toString();
      retorno = await repository.editarCliente(id, cliente.value);
    } catch (e) {
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }
}
