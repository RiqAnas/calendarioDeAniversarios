import 'dart:async';

import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/utils/databaseUtil.dart';
import 'package:flutter/material.dart';

class Noteservice extends ChangeNotifier {
  final _notes = StreamController<List<Note>>.broadcast();

  Stream<List<Note>> get notes {
    return _notes.stream;
  }

  Future<void> loadNotesperPerson(String personId) async {
    try {
      final list = await Databaseutil.loadPerPerson('notes', personId);
      final List<Note> notes = list.map((note) => Note.fromJson(note)).toList();

      _notes.add(notes.reversed.toList());
    } catch (error) {
      throw 'Erro ao carregar notas da pessoa';
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadFavoritesPerPerson(String personId) async {
    try {
      final list = await Databaseutil.loadPerPerson('notes', personId);
      final List<Note> notes = list.map((note) => Note.fromJson(note)).toList();

      _notes.add(notes.where((note) => note.favorite == true).toList());
    } catch (error) {
      throw 'Erro ao carregar notas da pessoa';
    } finally {
      notifyListeners();
    }
  }

  Future<void> insertNote(Note note) async {
    try {
      await Databaseutil.insert('notes', note.toJson());
      loadNotesperPerson(note.personid);
    } catch (error) {
      throw 'Erro ao inserir nota';
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await Databaseutil.update('notes', note.toJson(), note.id);
      loadNotesperPerson(note.personid);
    } catch (error) {
      throw 'Erro ado editar nota';
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      await Databaseutil.delete('notes', note.id);
      loadNotesperPerson(note.personid);
    } catch (error) {
      throw 'Erro ao deletar nota';
    }
  }

  Future<void> deleteAllNotes(String personId) async {
    try {
      await Databaseutil.deletePerPerson('notes', personId);
      loadNotesperPerson(personId);
    } catch (error) {
      throw 'Erro ao tentar deletar todas as notas';
    }
  }

  @override
  void dispose() {
    _notes.close();
    super.dispose();
  }
}
