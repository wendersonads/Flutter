import 'package:api_connect/view/client_view.dart';
import 'package:api_connect/view/product_view.dart';
import 'package:flutter/material.dart';

class OpenView extends StatelessWidget {
  const OpenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClientView(),
                  ),
                );
              },
              child: const Text('to Client'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductView(),
                  ),
                );
              },
              child: const Text('to Product'),
            ),
          ],
        ),
      ),
    );
  }
}
