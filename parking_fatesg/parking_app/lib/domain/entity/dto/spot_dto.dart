import 'dart:convert';

class SpotDTO {
  final String plate;

  SpotDTO({
    required this.plate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'plate': plate,
    };
  }

  String toJson() => json.encode(toMap());
}
