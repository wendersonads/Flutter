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
      await _abstractService.getUrl('cliente/'),
      headers: token.sendToken(),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      var clientes = jsonList.map((e) => ClienteModel.fromJson(e)).toList();
      return clientes;
    } else {
      _tokenService.delete();
      var error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
      throw error;
    }
  }

  Future<void> salvarNovoFornecedor(ClienteModel cli) async {
    try {
      Token token = _tokenService.get();

      // Converte o objeto fornecedor para JSON
      final novoCliJson = cli.toJson();

      // Envia a requisição POST para o servidor
      Response response = await post(
        await _abstractService.getUrl('cliente/'),
        headers: {
          ...token.sendToken(),
          'Content-Type':
              'application/json', // Certifique-se de incluir este cabeçalho
        },
        body: novoCliJson,
      );

      if (response.statusCode == 200) {
        Notificacao.snackBar('Fornecedor criado com sucesso');
      } else {
        var error = jsonDecode(response.body)['message'];
        Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      }
    } catch (e) {
      Notificacao.snackBar(e.toString(),
          tipoNotificacao: TipoNotificacaoEnum.error);
    }
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
