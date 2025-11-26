class Person {
  String? id;
  String? nome;
  DateTime? nascimento;
  int? idade;
  int? ativa;

  Person({
    required this.id,
    required this.nome,
    required this.nascimento,
    required this.idade,
    required this.ativa,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'nascimento': nascimento!.toIso8601String(),
      'idade': idade,
      'ativa': ativa,
    };
  }

  static Person fromJson(Map<String, dynamic> data) {
    return Person(
      id: data['id'],
      nome: data['nome'],
      nascimento: DateTime.tryParse(data['nascimento']),
      idade: data['idade'],
      ativa: data['ativa'],
    );
  }
}
