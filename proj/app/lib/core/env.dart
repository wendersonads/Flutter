import 'dart:convert';

import 'package:flutter/services.dart';

class Env {

  static late Map<String, dynamic> _env;

  static loadEnv() async {
    _env = jsonDecode(await rootBundle.loadString('assets/env.json'));
  }

  static read(String key) => _env[key];
}