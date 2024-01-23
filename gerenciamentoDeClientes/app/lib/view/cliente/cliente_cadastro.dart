import 'package:auth_migration/domain/service/cliente_service.dart';
import 'package:auth_migration/shared/components/Notificacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:email_validator/email_validator.dart';

import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/InputComponent.dart';
import '../../shared/components/LoadingComponent.dart';
import '../../shared/components/PaginacaoComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/components/TitleComponent.dart';
import '../../shared/components/styles.dart';
import '../../shared/widgets/NavBarWidget.dart';
import '../../widgets/sidebar_widget.dart';

class ClienteCadastro extends StatelessWidget {
  ClienteCadastro({Key? key}) : super(key: key);
  final controller = Get.put(ClienteService());

  void _showTags(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info),
              SizedBox(
                width: 8,
              ),
              Text('Selecione os Tags'),
            ],
          ),
          content: Container(
              width: double.maxFinite,
              child: GetBuilder<ClienteService>(
                builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.tags.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: controller.tags[index].selecionado == false
                            ? Colors.white
                            : primaryColorHover,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              child: Container(
                                child: Text(
                                    controller.tags[index].nomeTag.toString()),
                              ),
                              onTap: () {
                                controller.selecionarTags(index);
                              }),
                        ),
                      );
                    },
                  );
                },
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                controller.salvarTags();
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

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
                if (controller.nomeCliente.text.isEmpty ||
                    controller.emailCliente.text.isEmpty) {
                  Notificacao.snackBar('Todos os campos são obrigatórios!',
                      tipoNotificacao: TipoNotificacaoEnum.error);
                  return;
                }
                if (!EmailValidator.validate(
                    controller.emailCliente.text.toString())) {
                  Notificacao.snackBar('Email Inválido!',
                      tipoNotificacao: TipoNotificacaoEnum.error);
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
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
            child: ButtonComponent(
              color: primaryColor,
              onPressed: () {
                _showTags(context);
              },
              text: 'Selecionar Tags',
            ),
          ),
        ],
      )
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
