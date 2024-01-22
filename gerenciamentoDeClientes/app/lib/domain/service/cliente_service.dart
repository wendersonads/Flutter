import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/repository/cliente_repository.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/components/MaskFormatter.dart';
import '../model/pagina_model.dart';

class ClienteService extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  late MaskFormatter maskFormatter = MaskFormatter();
  String pesquisar = '';
  var carregando = true.obs;
  late RxList<ClienteModel> clientes;
  late Pagina pagina;
  late ClienteRepository repository;
  late TextEditingController nomeCliente;
  late TextEditingController emailCliente;

  ClienteService() {
    nomeCliente = TextEditingController();
    emailCliente = TextEditingController();
    repository = ClienteRepository();
    clientes = <ClienteModel>[].obs;
    pagina = Pagina(total: 0, atual: 1);
  }

  @override
  void onInit() {
    listaClientes();
    super.onInit();
  }

  Future<void> listaClientes() async {
    try {
      carregando(true);
      clientes.value = await repository.listarClientes();
    } catch (e) {
      carregando(false);
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
  }

  void deletarCliente(int i) {}

  Future<bool> salvarCliente() async {
    late bool retorno = false;
    try {
      ClienteModel novo =
          ClienteModel(email: emailCliente.text, nome: nomeCliente.text);
      retorno = await repository.salvarNovoCli(novo);
    } catch (e) {
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }
}
