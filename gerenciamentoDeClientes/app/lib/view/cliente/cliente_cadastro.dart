import 'package:auth_migration/domain/service/cliente_service.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/InputComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/components/styles.dart';
import '../../shared/widgets/NavBarWidget.dart';
import '../../widgets/sidebar_widget.dart';

class ClienteCadastro extends StatelessWidget {
  ClienteCadastro({Key? key}) : super(key: key);
  final controller = Get.put(ClienteService());

  Widget _buildBotaoPrincipal(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          child: ButtonComponent(
            color: Colors.red,
            onPressed: () {
              Get.offAllNamed('/home');
            },
            text: 'Fechar',
          ),
        ),
        const SizedBox(
          width: 150,
        ),
        Expanded(
          child: SizedBox(
            child: ButtonComponent(
              color: primaryColor,
              onPressed: () async {
                if (controller.nomeCliente.text.isEmpty || controller.emailCliente.text.isEmpty) {
                      Notificacao.snackBar('Todos os campos são obrigatórios!', tipoNotificacao: TipoNotificacaoEnum.error);
                      return;
                }
                if (await controller.salvarCliente()) {
                  Get.offAllNamed('/clientes');
                }
              },
              text: 'Salvar',
            ),
          ),
        )
      ],
    );
  }

  Widget _camposIniciais(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const TextComponent('Cadastrar Cliente'),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: TextComponent(
              'Nome',
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            child: InputComponent(
              controller: controller.nomeCliente,
              hintText: 'Nome',
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: TextComponent(
              'Email',
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            child: InputComponent(
              controller: controller.emailCliente,
              hintText: 'Email',
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavbarWidget(),
      drawer: const Sidebar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _camposIniciais(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildBotaoPrincipal(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
