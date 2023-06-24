import 'package:api_connect/core/env.dart';

class BaseService {
  final String path;

  BaseService(this.path);

  Uri getUri() {
    return Uri.parse(Env.read('url') + path);
  }
}