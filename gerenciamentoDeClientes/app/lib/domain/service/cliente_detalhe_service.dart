import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/repository/cliente_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/Notificacao.dart';

class ClienteDetalheService extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int id;
  late TextEditingController nomeCliente;
  late TextEditingController emailCliente;
  late Rx<ClienteModel> cliente;
  late ClienteRepository repository;
  var carregandoCliente = false.obs;

  ClienteDetalheService(Id) {
    nomeCliente = TextEditingController();
    emailCliente = TextEditingController();
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
    } catch (e) {
      carregandoCliente(true);
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    } finally {
      carregandoCliente(false);
    }
  }

  editarCliente() {}
}
