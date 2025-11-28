import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/utils/databaseUtil.dart';
import 'package:flutter/material.dart';

class Noteservice extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  Future<List<Note>> loadNotesperPerson(String personId) async {
    _notes.clear();
    try {
      final list = await Databaseutil.loadPerPerson('notes', personId);
      for (Map<String, dynamic> note in list) {
        _notes.add(Note.fromJson(note));
      }

      return _notes;
    } catch (error) {
      throw 'Erro ao carregar notas da pessoa';
    }
  }

  Future<void> insertNote(Note note) async {
    try {
      await Databaseutil.insert('notes', note.toJson());
      notifyListeners();
    } catch (error) {
      throw 'Erro ao inserir nota';
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await Databaseutil.update('notes', note.toJson(), note.id);
      notifyListeners();
    } catch (error) {
      throw 'Erro ado editar nota';
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      await Databaseutil.delete('notes', note.id);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao deletar nota';
    }
  }

  Future<void> deleteAllNotes(String personId) async {
    try {
      await Databaseutil.deletePerPerson('notes', personId);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar deletar todas as notas';
    }
  }
}
