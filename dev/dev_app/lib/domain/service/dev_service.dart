import 'dart:convert';

import 'package:dev_app/core/env.dart';
import 'package:dev_app/domain/entity/dev.dart';
import 'package:dev_app/domain/entity/dto/dev_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class DevService {
  
  Future<List<Dev>> findAll() async {
    Response response = await get(Uri.parse(Env.read('url') + '/dev'));
    if (response.statusCode == 200) {
      return fromJsonList(response.body);
    }
    return [];
  }

  Future<List<Dev>> findAllEnabled() async {
    Response response = await get(Uri.parse(Env.read('url') + '/dev' + '/enabled'));
    if (response.statusCode == 200) {
      return fromJsonList(response.body);
    }
    return [];
  }

  Future<Dev> save(DevDTO dto) async {
    Response response = await post(Uri.parse(Env.read('url') + '/dev'), headers: {'Content-Type': 'application/json'}, body: dto.toJson());
    if (response.statusCode == 200) {
      return Dev.fromJson(response.body);
    }
    throw Fluttertoast.showToast(msg: 'Error');
  }

  List<Dev> fromJsonList(String json) {
    return jsonDecode(json).map<Dev>((data) => Dev.fromJson(json)).toList();
  }
}