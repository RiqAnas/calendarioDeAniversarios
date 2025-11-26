import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/utils/databaseUtil.dart';
import 'package:flutter/material.dart';

class Personservice extends ChangeNotifier {
  final List<Person> _persons = [];

  List<Person> get persons {
    return [..._persons];
  }

  Future<void> loadPersons() async {
    try {
      final list = await Databaseutil.loadTable('persons');

      for (Map<String, dynamic> obj in list) {
        _persons.add(Person.fromJson(obj));
      }
      notifyListeners();
    } catch (error) {
      throw 'Erro inesperado ao carregar pessoas';
    }
  }

  Future<Person> getPerson(String id) async {
    try {
      final list = await Databaseutil.loadSingle('persons', id);

      return Person.fromJson(list.first);
    } catch (error) {
      throw 'Erro ao tentar adquirir dados da pessoa';
    }
  }

  Future<void> insertPerson(Person person) async {
    try {
      await Databaseutil.insert('persons', person.toJson());
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar inserir pessoa';
    }
  }

  Future<void> updatePerson(Person person) async {
    try {
      await Databaseutil.update('persons', person.toJson(), person.id!);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar atualizar pessoa';
    }
  }

  Future<void> inactivatePerson(Person person) async {
    try {
      Person persona = Person(
        id: person.id,
        nome: person.nome,
        nascimento: person.nascimento,
        idade: person.idade,
        ativa: 0,
      );
      await Databaseutil.update('persons', persona.toJson(), person.id!);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar deletar informações da pessoa';
    }
  }

  Future<void> deletePerson(Person person) async {
    try {
      await Databaseutil.delete('persons', person.id!);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar deletar informações da pessoa';
    }
  }
}
