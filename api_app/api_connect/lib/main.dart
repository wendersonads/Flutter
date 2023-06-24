import 'package:api_connect/core/env.dart';
import 'package:api_connect/view/open_view.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.loadEnv();
  runApp(
    const MaterialApp(
      home: OpenView(),
    ),
  );
}
