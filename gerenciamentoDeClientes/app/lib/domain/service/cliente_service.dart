import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/model/tags_cliente.dart';
import 'package:auth_migration/domain/repository/cliente_repository.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/components/MaskFormatter.dart';
import '../model/cliente_tags_model.dart';
import '../model/pagina_model.dart';

class ClienteService extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GlobalKey<FormState> formFiltragemTagsKey;
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  late MaskFormatter maskFormatter = MaskFormatter();
  String pesquisar = '';
  var carregando = true.obs;
  var carregandoTags = false.obs;
  late RxList<ClienteModel> clientes;
  late Pagina pagina;
  late ClienteRepository repository;
  late TextEditingController nomeCliente;
  late TextEditingController emailCliente;
  late RxList<TagsCliente> tags;
  late RxList<TagsCliente> tagsSelecionadas;
  late Rx<ClienteModel> novo;

  ClienteService() {
    nomeCliente = TextEditingController();
    emailCliente = TextEditingController();
    repository = ClienteRepository();
    clientes = <ClienteModel>[].obs;
    pagina = Pagina(total: 0, atual: 1);
    formFiltragemTagsKey = GlobalKey<FormState>();
    tags = <TagsCliente>[].obs;
    tagsSelecionadas = <TagsCliente>[].obs;
    novo = ClienteModel().obs;
  }

  @override
  void onInit() async {
    await listaClientes();
    await listarTags();
    super.onInit();
  }

  void fecharDialog() {
    Get.back();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> listarTags() async {
    try {
      carregandoTags(true);
      tags.value = await repository.buscarTags();
    } catch (e) {
      carregandoTags(false);
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    } finally {
      carregandoTags(true);
    }
  }

  Future<void> listaClientes() async {
    try {
      carregando(true);
      clientes.value = await repository.listarClientes();
    } catch (e) {
      carregando(false);
      print(e.toString());
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
  }

  Future<bool> deletarCliente(int i) async {
    late bool retorno;
    try {
      retorno = await repository.deletarCliente(i);
    } catch (e) {
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }

  Future<bool> salvarCliente() async {
    late bool retorno = false;
    try {
      novo.value.nome = nomeCliente.text;
      novo.value.email = emailCliente.text;
      List<ClienteTags> cliTags = [];
      for (var element in tagsSelecionadas) {
        ClienteTags tagCli = ClienteTags();
        tagCli.cliente = novo.value;
        tagCli.tag = element;
        
        cliTags.add(tagCli);
      }
      novo.value = ClienteModel(clienteTags:cliTags, nome: nomeCliente.text, email: emailCliente.text);
      retorno = await repository.salvarNovoCli(novo.value);
    } catch (e) {
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }

  void selecionarTags(index) {
    bool aletera = !tags[index].selecionado!;
    tags[index].selecionado = aletera;
    tagsSelecionadas.value = tags.where((element) => element.selecionado == true).toList();
    update();
  }

  buscarTags() {}

  void confirmarSelecaoTags() {}

  void salvarTags() {}
}
