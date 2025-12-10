import 'dart:async';

import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/utils/databaseUtil.dart';
import 'package:flutter/material.dart';

class Folderservice extends ChangeNotifier {
  final _folders = StreamController<List<Folder>>.broadcast();

  Stream<List<Folder>> get folders {
    return _folders.stream;
  }

  Folder? _folder;

  Folder? get folder {
    return _folder;
  }

  Future<void> loadFoldersperPerson(String personId) async {
    try {
      final list = await Databaseutil.loadPerPerson('folders', personId);
      final List<Folder> folders = list
          .map((fol) => Folder.fromJson(fol))
          .toList();
      _folders.add(folders);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao carregar pastas por pessoas';
    }
  }

  Future<Folder?> getFolder(String? id) async {
    try {
      if (id == null) {
        return null;
      }
      final list = await Databaseutil.loadSingle('folders', id);
      return Folder.fromJson(list.first);
    } catch (error) {
      throw "Erro ao tentar carregar pasta";
    }
  }

  Future<void> insertFolder(Folder folder) async {
    try {
      await Databaseutil.insert('folders', folder.toJson());
      loadFoldersperPerson(folder.personId);
    } catch (error) {
      throw 'Erro ao inserir pasta';
    }
  }

  Future<void> updateFolder(Folder folder) async {
    try {
      await Databaseutil.update('folders', folder.toJson(), folder.id);
      loadFoldersperPerson(folder.personId);
    } catch (error) {
      throw 'Erro ao atualizar pasta';
    }
  }

  Future<void> deleteFolder(Folder folder) async {
    try {
      await Databaseutil.delete('folders', folder.id);
      loadFoldersperPerson(folder.personId);
    } catch (error) {
      throw 'Erro ao deletar pasta';
    }
  }
}
