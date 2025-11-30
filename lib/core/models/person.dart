class Person {
  String id;
  String? nome;
  DateTime? nascimento;
  String telefone;
  int? idade;
  int? ativa;

  Person({
    required this.id,
    required this.nome,
    required this.nascimento,
    required this.telefone,
    required this.idade,
    required this.ativa,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'nascimento': nascimento!.toIso8601String(),
      'idade': idade,
      'ativa': ativa,
    };
  }

  static Person fromJson(Map<String, dynamic> data) {
    return Person(
      id: data['id'],
      nome: data['nome'],
      telefone: data['telefone'],
      nascimento: DateTime.tryParse(data['nascimento']),
      idade: data['idade'],
      ativa: data['ativa'],
    );
  }
}
