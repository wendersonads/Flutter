import 'package:app/core/env.dart';
import 'package:http/http.dart';

class DevService {
  
  Future<String> getData() async {
    Response response = await get(Uri.parse(Env.read('url') + '/dev'));
    return response.body;
  }
}