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
      Databaseutil.insert('notes', note.toJson());
      notifyListeners();
    } catch (error) {
      throw 'Erro ao inserir nota';
    }
  }
}
