import 'package:auth_migration/domain/service/cliente_detalhe_service.dart';
import 'package:auth_migration/view/cliente/cliente_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/dispositivo.dart';

class ClienteDetalheView extends StatelessWidget{
final int id;
const ClienteDetalheView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(ClienteDetalheService(id));

    if (Dispositivo.mobile(context.width)) {
      return  ClienteEdit();
    } 
    return Container();
  }
}