import 'package:auth_migration/domain/model/peca_model.dart';
import 'package:auth_migration/domain/service/cliente_service.dart';
import 'package:auth_migration/shared/components/styles.dart';
import 'package:auth_migration/view/cliente/cliente_edit.dart';
import 'package:auth_migration/view/peca/peca_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/InputComponent.dart';
import '../../shared/components/LoadingComponent.dart';
import '../../shared/components/PaginacaoComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/widgets/CardWidget.dart';
import '../../shared/widgets/NavBarWidget.dart';
import '../../widgets/sidebar_widget.dart';

class ClienteList extends StatelessWidget {
  const ClienteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Get.put<ClienteService>(ClienteService());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NavbarWidget(),
      drawer: const Sidebar(),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextComponent(
                  'Clientes',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 2,
                    child: InputComponent(
                      hintText: 'Buscar',
                      onChanged: (value) {
                        service.pesquisar = value;
                      },
                      onFieldSubmitted: (value) async {
                        service.pesquisar = value;
                        await service.listaClientes();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: ButtonComponent(
                      onPressed: () async {
                        await service.listaClientes();
                      },
                      text: 'Buscar',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Obx(() {
                return !service.carregando.value
                    ? const LoadingComponent()
                    : ListView.builder(
                        itemCount: service.clientes.length,
                        itemBuilder: (context, index) {
                          final cliente = service.clientes[index];
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CardWidget(
                                widget: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'ID Cliente',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            cliente.idCliente.toString(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'Nome',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            cliente.nome ?? '',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'Email',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            cliente.email ?? '',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextComponent('Ações',
                                                  fontWeight: FontWeight.bold)),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              Get.toNamed('/clientes/' +
                                                  service
                                                      .clientes[index].idCliente
                                                      .toString());
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            alignment: Alignment.centerRight,
                                            onPressed: () {
                                              Get.defaultDialog(
                                                title: 'Confirmar Exclusão',
                                                content: const Text(
                                                  'Deseja realmente excluir o cliente?',
                                                  textAlign: TextAlign.center,
                                                ),
                                                confirm: ElevatedButton(
                                                  onPressed: () async {
                                                    Get.back();
                                                    service.deletarCliente(
                                                      service.clientes[index]
                                                          .idCliente!,
                                                    );
                                                    service.clientes
                                                        .removeAt(index);
                                                    Get.forceAppUpdate();
                                                    await service
                                                        .listaClientes(); // Fix: use listaClientes instead of lista
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        primaryColor, // Cor azul escuro
                                                  ),
                                                  child: Text('Confirmar'),
                                                ),
                                                cancel: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Cor azul escuro
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('Cancelar'),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
            GetBuilder<ClienteService>(
              builder: (_) => PaginacaoComponent(
                total: service.pagina.getTotal(),
                atual: service.pagina.getAtual(),
                primeiraPagina: () {
                  service.pagina.primeira();
                  service.listaClientes();
                },
                anteriorPagina: () {
                  service.pagina.anterior();
                  service.listaClientes();
                },
                proximaPagina: () {
                  service.pagina.proxima();
                  service.listaClientes();
                },
                ultimaPagina: () {
                  service.pagina.ultima();
                  service.listaClientes();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
