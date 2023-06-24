import 'dart:convert';

class Product {
  final int id;

  final String name;

  final String description;

  Product({required this.id, required this.name, required this.description});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(id: map['id'], name: map['name'], description: map['description']);
  }

  factory Product.fromJson(String json) {
    return Product.fromMap(jsonDecode(json));
  }

  static List<Product> fromJsonList(String json) {
    return jsonDecode(json).map<Product>((map) => Product.fromMap(map)).toList();
  }
}