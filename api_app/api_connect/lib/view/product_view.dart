import 'package:api_connect/domain/entity/product.dart';
import 'package:api_connect/domain/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductService service = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: service.findAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => productCard(
                snapshot.data![index],
              ),
            );
          }
        },
      ),
    );
  }

  productCard(Product product) {
    return Card(
      child: Column(
        children: [
          Text(
            product.id.toString(),
          ),
          Text(
            product.name,
          ),
          Text(
            product.description,
          ),
        ],
      ),
    );
  }
}
