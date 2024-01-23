import 'package:auth_migration/base/service/base_service.dart';
import 'package:auth_migration/core/auth/token_service.dart';
import 'package:auth_migration/core/auth/usuario_service.dart';
import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/model/tags_cliente.dart';
import 'package:auth_migration/domain/model/token_model.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:auth_migration/view/splash/splash_screen.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:get/get.dart' as gett;

class ClienteRepository {
  final BaseService _abstractService = BaseService('');

  final TokenService _tokenService = TokenService();

  final UsuarioService _usuarioService = UsuarioService();

  Future<List<ClienteModel>> listarClientes() async {
    Token token = _tokenService.get();

    Response response = await get(
      await _abstractService.getUrl('/cliente/'),
      headers: token.sendToken(),
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      List<ClienteModel> clientes = jsonList
          .map<ClienteModel>((data) => ClienteModel.fromJson(data))
          .toList();
      return clientes;
    } else {
      _tokenService.delete();
      var error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
      throw error;
    }
  }

  Future<List<TagsCliente>> buscarTags() async {
    Token token = _tokenService.get();

    Response response = await get(
      await _abstractService.getUrl('/tags/'),
      headers: token.sendToken(),
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      List<TagsCliente> tags = jsonList
          .map<TagsCliente>((data) => TagsCliente.fromJson(data))
          .toList();

      tags.forEach(
        (element) {
          print(element.nomeTag);
        },
      );
      return tags;
    } else {
      _tokenService.delete();
      var error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
      throw error;
    }
  }

  Future<bool> salvarNovoCli(ClienteModel cli) async {
    late bool retorno = false;
    try {
      Token token = _tokenService.get();
      final novoCliJson = cli.toJson();
      Response response = await post(
        await _abstractService.getUrl('/cliente/'),
        headers: {
          ...token.sendToken(),
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(novoCliJson),
      );

      if (response.statusCode == 200) {
        retorno = true;
        Notificacao.snackBar('Cliente criado com sucesso');
      } else {
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
        retorno = false;
      }
    } catch (e) {
      print(e.toString());
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }

    return retorno;
  }

  Future<bool> editarCliente(int id, ClienteModel cli) async {
    late bool retorno;
    try {
      Token token = _tokenService.get();
      Response response = await put(
        await _abstractService.getUrl('/cliente/${id}'),
        headers: {
          ...token.sendToken(),
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(cli),
      );

      if (response.statusCode == 200) {
        retorno = true;
        Notificacao.snackBar('Cliente editado com sucesso');
      } else {
        retorno = false;
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      }
    } catch (e) {
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return retorno;
  }

  Future<ClienteModel> buscarPorId(int id) async {
    Token token = _tokenService.get();
    var error;
    late ClienteModel cliente;

    Response response = await get(
        await _abstractService.getUrl('/cliente/' + id.toString()),
        headers: token.sendToken());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      cliente = ClienteModel.fromJson(data);
    } else if (response.statusCode == 401) {
      _tokenService.delete();
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
    } else {
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
    }

    return cliente;
  }

  Future<bool> deletarCliente(int idCli) async {
    late bool retorno = false;
    try {
      Token token = _tokenService.get();
      Response response = await delete(
        await _abstractService.getUrl('cliente/$idCli'),
        headers: token.sendToken(),
      );
      if (response.statusCode == 200) {
        retorno = true;
        Notificacao.snackBar('Cliente deletado com sucesso');
      } else {
        retorno = false;
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      }
    } catch (e) {
      retorno = false;
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }

    return retorno;
  }
}
