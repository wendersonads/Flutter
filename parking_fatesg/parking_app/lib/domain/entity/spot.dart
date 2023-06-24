// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Spot {
  final int id;
  final String plate;
  final DateTime entry;
  late DateTime exit;
  late double payment;
  final String status;

  Spot({
    required this.id,
    required this.plate,
    required this.entry,
    required this.exit,
    required this.payment,
    required this.status,
  });

  factory Spot.fromMap(Map<String, dynamic> map) {
    return Spot(
      id: map['id'],
      plate: map['plate'],
      entry: DateTime.parse(map['entry']),
      exit: DateTime.parse(map['exit']),
      payment: map['payment'],
      status: map['status'],
    );
  }

  factory Spot.fromJson(String source) => Spot.fromMap(json.decode(source) as Map<String, dynamic>);

  display() {
    return 'Value: $payment';
  }
}
