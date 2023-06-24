// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Dev {
  final int id;

  final String name;

  final double total;

  final DateTime date;

  final String uuid;

  final bool enabled;

  Dev({
    required this.id,
    required this.name,
    required this.total,
    required this.date,
    required this.uuid,
    required this.enabled,
  });

  factory Dev.fromMap(Map<String, dynamic> map) {
    return Dev(
      id: map['id'],
      name: map['name'],
      total: map['total'],
      date: DateTime.parse(map['date']),
      uuid: map['uuid'],
      enabled: map['enabled'],
    );
  }

  factory Dev.fromJson(String source) => Dev.fromMap(jsonDecode(source));
}
