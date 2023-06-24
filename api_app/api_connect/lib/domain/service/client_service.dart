import 'package:api_connect/domain/entity/client.dart';
import 'package:api_connect/domain/service/base_service.dart';
import 'package:http/http.dart' as http;

class ClientService extends BaseService {

  ClientService() : super('/client');
  
  Future<List<Client>> findAll() async {
    http.Response response = await http.get(getUri());
    return Client.fromJsonList(response.body);
  }
}