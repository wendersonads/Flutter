import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:parking_app/core/prefs.dart';
import 'package:parking_app/domain/entity/dto/spot_dto.dart';
import 'package:parking_app/domain/entity/spot.dart';

class SpotService {
  Future<void> save(String plate) async {
    SpotDTO dto = SpotDTO(plate: plate);
    Response response = await post(
      Uri.parse(Prefs.url),
      headers: {'Content-Type': 'application/json'},
      body: dto.toJson(),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Done!');
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
  }

  Future<void> update(String plate) async {
    SpotDTO dto = SpotDTO(plate: plate);
    Response response = await put(
      Uri.parse(Prefs.url),
      headers: {'Content-Type': 'application/json'},
      body: dto.toJson(),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: Spot.fromJson(response.body).display(), timeInSecForIosWeb: 10, gravity: ToastGravity.CENTER);
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
  }
}
