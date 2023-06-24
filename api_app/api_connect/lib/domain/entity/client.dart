import 'dart:convert';

class Client {
  final int id;

  final String name;

  final String clazz;

  Client({
    required this.id,
    required this.name,
    required this.clazz,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as int,
      name: map['name'] as String,
      clazz: map['clazz'] as String,
    );
  }

  factory Client.fromJson(String source) => Client.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Client> fromJsonList(String json) {
    return jsonDecode(json).map<Client>((map) => Client.fromMap(map)).toList();
  }
}
