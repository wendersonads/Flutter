import 'package:auth_migration/domain/model/cliente_tags_model.dart';
import 'package:auth_migration/domain/model/tags_cliente.dart';

class ClienteModel {
  int? idCliente;
  String? nome;
  String? email;
  List<ClienteTags>? clienteTags;

  ClienteModel({this.idCliente, this.nome, this.email, this.clienteTags});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCliente'] = idCliente;
    data['nome'] = nome;
    data['email'] = email;
    if (clienteTags != null) {
      data['clienteTags'] = clienteTags!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic>? subList = map['clienteTags'];
    final List<ClienteTags>? clienteTags;
    if (subList != null) {
      clienteTags = subList.map((e) => ClienteTags.fromMap(e)).toList();
    } else {
      clienteTags = null;
    }
    return ClienteModel(
        idCliente: map['idCliente'],
        nome: map['nome'],
        email: map['email'],
        clienteTags: clienteTags);
  }

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nome = json['nome'];
    email = json['email'];
    clienteTags = [];
    if (json['clienteTags'] != null) {
      json['clienteTags'].forEach((f) {
        clienteTags?.add(ClienteTags.fromJson(f));
      });
    }
  }
}
