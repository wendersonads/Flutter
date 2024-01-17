import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/service/peca_service.dart';
import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/InputComponent.dart';
import '../../shared/components/LoadingComponent.dart';
import '../../shared/components/PaginacaoComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/widgets/CardWidget.dart';
import '../../shared/widgets/NavBarWidget.dart';
import '../../widgets/sidebar_widget.dart';
import 'peca_details.dart';

class PecaList extends StatelessWidget {
  const PecaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Get.put<PecaService>(PecaService());

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
                  'Peças',
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
                        await service.listaPecas();
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
                        await service.listaPecas();
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
              child: Obx(() => !service.carregando.value
                  ? ListView.builder(
                      itemCount: service.pecas.length,
                      itemBuilder: (context, index) {
                        final peca = service.pecas[index];
                        return InkWell(
                          onTap: () {
                            print('Clicou na peça: ${peca.idPeca}');
                            // Navegar para a tela de detalhes ao clicar na peça
                            Get.to(
                              () => PecaDetails(peca: peca),
                            );
                          },
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
                                            'ID Peça',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SelectableText(
                                          peca.idPeca.toString(),
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
                                          peca.descricao?.capitalize ?? '',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: TextComponent(
                                            'Produto',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: SelectableText(
                                            peca.produto?.descricao
                                                    .toString() ??
                                                '',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const LoadingComponent()),
            ),
            GetBuilder<PecaService>(
              builder: (_) => PaginacaoComponent(
                total: service.pagina.getTotal(),
                atual: service.pagina.getAtual(),
                primeiraPagina: () {
                  service.pagina.primeira();
                  service.listaPecas();
                },
                anteriorPagina: () {
                  service.pagina.anterior();
                  service.listaPecas();
                },
                proximaPagina: () {
                  service.pagina.proxima();
                  service.listaPecas();
                },
                ultimaPagina: () {
                  service.pagina.ultima();
                  service.listaPecas();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
