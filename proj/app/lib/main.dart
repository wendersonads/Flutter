import 'package:app/core/env.dart';
import 'package:app/domain/view/home_screen.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.loadEnv();
  runApp(
    const MaterialApp(
      title: 'APP',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
