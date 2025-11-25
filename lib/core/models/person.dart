class Person {
  String? id;
  String? nome;
  DateTime? nascimento;
  int? idade;

  Person({
    required this.id,
    required this.nome,
    required this.nascimento,
    required this.idade,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'nascimento': nascimento!.toIso8601String(),
      'idade': idade,
    };
  }

  Person fromJson(Map<String, dynamic> data) {
    return Person(
      id: data['id'],
      nome: data['nome'],
      nascimento: DateTime.tryParse(data['nascimento']),
      idade: data['idade'],
    );
  }
}
