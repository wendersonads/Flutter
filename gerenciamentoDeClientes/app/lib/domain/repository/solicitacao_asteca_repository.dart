import 'dart:convert';

import 'package:auth_migration/base/service/base_service.dart';
import 'package:auth_migration/core/auth/token_service.dart';
import 'package:auth_migration/domain/model/asteca_motivo_model.dart';
import 'package:auth_migration/domain/model/documento_fiscal_model.dart';
import 'package:auth_migration/domain/model/peca_estoque_model.dart';
import 'package:auth_migration/domain/model/solicitacao_asteca_model.dart';
import 'package:auth_migration/domain/model/token_model.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:get/get.dart' as gett;
import 'package:http/http.dart';

import '../../view/splash/splash_screen.dart';

class SolicitacaoAstecaRepository {
  final BaseService _baseService = BaseService('');
  final TokenService _tokenService = TokenService();
  var carregandoNotas = false.obs;

  Future<List<DocumentoFiscal>> notasFiscaisPorProduto(int IdProduto) async {
    Token token = _tokenService.get();
    var error;
    Response response = await get(
        await _baseService.getUrl('doc/' + IdProduto.toString()),
        headers: token.sendToken());
    if (response.statusCode == 200) {
      carregandoNotas(true);
      var data = jsonDecode(response.body);
      List<DocumentoFiscal> docs = data
          .map<DocumentoFiscal>((data) => DocumentoFiscal.fromJson(data))
          .toList();
      return docs;
    } else if (response.statusCode == 401) {
      _tokenService.delete();
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
    } else {
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
    }
    return [];
  }

  Future<List<AstecaMotivo>> motivosCriacaoAsteca() async {
    Token token = _tokenService.get();
    Response response = await get(await _baseService.getUrl('/astecamotivo/'),
        headers: token.sendToken());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<AstecaMotivo> motivos =
          data.map<AstecaMotivo>((data) => AstecaMotivo.fromMap(data)).toList();
      return motivos;
    }
    return [];
  }

  Future<List<PecaEstoque>> listarPorProduto(int IdProduto) async {
    Token token = _tokenService.get();
    var error;
    Response response = await get(
        await _baseService.getUrl('/pecasestoque/prod/' + IdProduto.toString()),
        headers: token.sendToken());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PecaEstoque> pecasEstoque =
          data.map<PecaEstoque>((data) => PecaEstoque.fromMap(data)).toList();
      return pecasEstoque;
    } else if (response.statusCode == 401) {
      _tokenService.delete();
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
    }
    return [];
  }

  Future<bool> novaSolicitacao(SolicitacaoAstecaModel asteca) async {
    Token token = _tokenService.get();
    var error;
    bool result = false; 
    Response response = await post(await _baseService.getUrl('/asteca/'),
        headers: {'Content-Type': 'application/json', ...token.sendToken()},
        body: jsonEncode(asteca),
        );
    if (response.statusCode == 201) {
      result = true;
    } else if (response.statusCode == 401) {
       _tokenService.delete();
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
      result = false;
    } else {
      error = jsonDecode(response.body)['message'];
      Notificacao.snackBar(error, tipoNotificacao: TipoNotificacaoEnum.error);
      result = false;
    }
    return result;
  }
}
