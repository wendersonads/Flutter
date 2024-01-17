import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/auth/usuario_service.dart';
import '../../shared/components/MaskFormatter.dart';
import '../model/pagina_model.dart';
import '../model/produto_model.dart';
import '../model/usuario_model.dart';
import '../repository/produto_repository.dart';

class ProdutoService extends GetxController {

  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  late MaskFormatter maskFormatter = MaskFormatter();
  String pesquisar = '';
  var carregando = true.obs;
  late ProdutoRepository produtoRepository;
  late List<Produto> produtos;
  late Pagina pagina;



  ProdutoService(){
    produtoRepository = ProdutoRepository();
    produtos = <Produto>[].obs;
    pagina = Pagina(total: 0, atual: 1);
  }

  @override
  void onInit() {
    listaProdutos();
    super.onInit();
  }

  listaProdutos() async {
    try {
      carregando(true);
      produtos = await produtoRepository.listaProdutos();
    } catch (e) {
     null;
    } finally {
      carregando(false);
      update();
    }
  }
}
