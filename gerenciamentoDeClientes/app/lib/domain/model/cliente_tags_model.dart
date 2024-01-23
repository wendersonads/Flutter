import 'package:auth_migration/domain/model/cliente_model.dart';
import 'package:auth_migration/domain/model/tags_cliente.dart';

class ClienteTags {
  int? id;
  ClienteModel? cliente;
  TagsCliente? tag;

  ClienteTags({this.id, this.cliente, this.tag});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cliente'] = cliente != null ? cliente!.toJson() : null;
    data['tag'] = tag != null ? tag!.toJson() : null;
    return data;
  }

  factory ClienteTags.fromMap(Map<String, dynamic> map) {
    return ClienteTags(
      id: map['id'],
      cliente: map['cliente'] != null ? ClienteModel.fromMap(map['cliente']) : null,
      tag: map['tag'] != null ? TagsCliente.fromMap(map['tag']) : null,
    );
  }

  ClienteTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cliente = json['cliente'] != null ? ClienteModel.fromJson(json['cliente']) : null;
    tag = json['tag'] != null ? TagsCliente.fromJson(json['tag']) : null;
  }
}
