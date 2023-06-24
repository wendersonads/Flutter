import 'package:dev_app/core/env.dart';
import 'package:dev_app/domain/view/dev_screen.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.loadEnv();
  runApp(
    const MaterialApp(
      title: 'DevApp',
      home: DevScreen(),
    ),
  );
}
