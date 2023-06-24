import 'package:api_connect/domain/entity/product.dart';
import 'package:api_connect/domain/service/base_service.dart';
import 'package:http/http.dart' as http;

class ProductService extends BaseService {

  ProductService() : super('/product');
  
  Future<List<Product>> findAll() async {
    http.Response response = await http.get(getUri());
    return Product.fromJsonList(response.body);
  }
}