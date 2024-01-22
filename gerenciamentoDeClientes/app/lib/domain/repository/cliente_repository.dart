import 'package:auth_migration/base/service/base_service.dart';
import 'package:auth_migration/core/auth/token_service.dart';
import 'package:auth_migration/core/auth/usuario_service.dart';
import 'package:auth_migration/domain/model/cliente_model.dart';
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
        Notificacao.snackBar('Fornecedor criado com sucesso');
      } else {
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
        retorno = false;
      }
    } catch (e) {
      retorno = false;
      print(e.toString());
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }

    return retorno;
  }

  Future<void> editarFornecedor(int id, ClienteModel cli) async {
    try {
      Token token = _tokenService.get();

      // Converte o objeto fornecedor para JSON
      final cliEditadoJson = cli.toJson();

      // Envia a requisição POST para o servidor
      Response response = await post(
        await _abstractService.getUrl('cliente/${id}'),
        headers: {
          ...token.sendToken(),
          'Content-Type':
              'application/json', // Certifique-se de incluir este cabeçalho
        },
        body: cliEditadoJson,
      );

      if (response.statusCode == 200) {
        Notificacao.snackBar('Fornecedor editado com sucesso');
      } else {
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      }
    } catch (e) {
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
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

  Future<void> deletarFornecedor(int idCli) async {
    try {
      Token token = _tokenService.get();

      // Envia a requisição DELETE para o servidor
      Response response = await delete(
        await _abstractService.getUrl('cliente/$idCli'),
        headers: token.sendToken(),
      );

      if (response.statusCode == 200) {
        Notificacao.snackBar('Fornecedor deletado com sucesso');
      } else {
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      }
    } catch (e) {
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
  }
}
