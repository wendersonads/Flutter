import 'package:app/core/env.dart';
import 'package:app/domain/service/dev_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DevService _devService = DevService();

  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(_value),
            ElevatedButton(
              onPressed: () => fetchData(),
              child: const Text('GET VALUE'),
            ),
          ],
        ),
      ),
    );
  }

  fetchData() async {
    _value = await _devService.getData();
    setState(() {});
  }
}
