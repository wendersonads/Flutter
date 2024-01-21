class ClienteModel {
  int? idCliente;
  String? nome;
  String? email;

  ClienteModel({this.idCliente, this.nome, this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCliente'] = idCliente;
    data['nome'] = nome;
    data['email'] = email;
    return data;
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      idCliente: map['idCliente'],
      nome: map['nome'],
      email: map['email'],
    );
  }

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['idCliente'];
    nome = json['nome'];
    email = json['email'];
  }
}
