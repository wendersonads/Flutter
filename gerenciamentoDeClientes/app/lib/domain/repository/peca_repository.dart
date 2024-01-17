import 'dart:convert';

import 'package:auth_migration/core/auth/usuario_service.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:auth_migration/view/splash/splash_screen.dart';
import 'package:get/get.dart' as gett;

import '../../base/service/base_service.dart';
import '../../core/auth/token_service.dart';
import '../model/peca_model.dart';
import 'package:http/http.dart';


import '../model/token_model.dart';

class PecaRepository {
  final BaseService _abstractService = BaseService('');
  final TokenService _tokenService = TokenService();
  
  Future<List<Peca>> listaPecas() async {
    Token token = _tokenService.get();

    Response response = await get(
        await _abstractService.getUrl('pecas/'),
        headers: token.sendToken(),
        );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      var pecas = jsonList.map((e) => Peca.fromJson(e)).toList();
      return pecas;
    } else {
      _tokenService.delete();
      var error = jsonDecode(response.body)['message'];
       Notificacao.snackBar(error,
         tipoNotificacao: TipoNotificacaoEnum.error);
      gett.Get.to(const SplashScreen());
      throw error;
    }
  }
}
