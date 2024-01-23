import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/repository/cliente_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/Notificacao.dart';
import '../model/cliente_tags_model.dart';
import '../model/tags_cliente.dart';

class ClienteDetalheService extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int id;
  TextEditingController nomeCliente = TextEditingController();
  TextEditingController emailCliente = TextEditingController();
  late Rx<ClienteModel> cliente;
  late ClienteRepository repository;
  var carregandoCliente = false.obs;
  var carregandoTags = false.obs;
  late RxList<TagsCliente> tags;
  late RxList<TagsCliente> tagsSelecionadas;

  ClienteDetalheService(Id) {
    id = Id;
    cliente = ClienteModel().obs;
    repository = ClienteRepository();
    tags = <TagsCliente>[].obs;
    tagsSelecionadas = <TagsCliente>[].obs;
  }

  @override
  void onInit() async {
    super.onInit();
    await buscarPorId();
    await listarTags();
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
      List<ClienteTags> cliTags = [];

       for (var element in tagsSelecionadas) {
        ClienteTags tagCli = ClienteTags();
        tagCli.cliente = cliente.value;
        tagCli.tag = element;
        
        cliTags.add(tagCli);
      }
      cliente.value = ClienteModel(clienteTags:cliTags, nome: nomeCliente.text, email: emailCliente.text);
      retorno = await repository.editarCliente(id, cliente.value);
    } catch (e) {
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }

  Future<void> listarTags() async {
    try {
      carregandoTags(true);
      tags.value = await repository.buscarTags();
      marcarTags();
    } catch (e) {
      carregandoTags(false);
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    } finally {
      carregandoTags(true);
    }
  }

  void selecionarTags(index) {
    bool aletera = !tags[index].selecionado!;
    tags[index].selecionado = aletera;
    tagsSelecionadas.value = tags.where((element) => element.selecionado == true).toList();
    update();
  }

  void marcarTags() {
    if (cliente.value.clienteTags!.isNotEmpty) {
      for (var element in tags.value) {
        for (var tagsCli in cliente.value.clienteTags!) {
          if (tagsCli.tag?.idTag == element.idTag) {
            element.selecionado = true;
          }
        }
      }
    }
  }
}
