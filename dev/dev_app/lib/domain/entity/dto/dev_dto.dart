// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DevDTO {
  final String name;

  final double total;

  final DateTime date;

  DevDTO({
    required this.name,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'total': total,
      'date': date.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
