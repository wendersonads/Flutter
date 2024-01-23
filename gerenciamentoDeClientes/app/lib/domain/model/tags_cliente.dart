class TagsCliente {
  int? idTag;
  String? nomeTag;
  bool? selecionado = false;


  TagsCliente({this.idTag, this.nomeTag, this.selecionado});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTag'] = idTag;
    data['nome'] = nomeTag;
    return data;
  }

  factory TagsCliente.fromMap(Map<String, dynamic> map) {
    return TagsCliente(
      idTag: map['idTag'],
      nomeTag: map['nome'],
    );
  }

  TagsCliente.fromJson(Map<String, dynamic> json) {
    idTag = json['idTag'];
    nomeTag = json['nome'];
  }
}
