import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class Databaseutil {
  static Future<sql.Database> database() async {
    final dbpath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbpath, 'birthday.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE persons (id TEXT PRIMARY KEY, nome TEXT NOT NULL, telefone TEXT NOT NULL, nascimento TEXT NOT NULL, idade INTEGER, ativa INTEGER NOT NULL)',
        );

        await db.execute(
          'CREATE TABLE notes (id TEXT PRIMARY KEY, personId TEXT NOT NULL, folderId TEXT, title TEXT NOT NULL, description TEXT, mark INTEGER NOT NULL, createdAt TEXT NOT NULL, marked INTEGER, date TEXT, color TEXT, textcolor TEXT, markview INTEGER NOT NULL, favorite INTEGER NOT NULL, FOREIGN KEY (personId) REFERENCES persons (id))',
        );

        await db.execute(
          'CREATE TABLE folders (id TEXT PRIMARY KEY, personId TEXT NOT NULL, folderId TEXT, name TEXT NOT NULL, color TEXT NOT NULL, createdAt TEXT NOT NULL)',
        );

        await db.execute(
          'CREATE TABLE settings (id TEXT PRIMARY KEY, color TEXT NOT NULL, mode INTEGER NOT NULL)',
        );

        await db.rawInsert('INSERT INTO settings VALUES ("0", "Azul", "1")');

        await db.rawInsert(
          'INSERT INTO persons VALUES ("home", "notas", "semnumero", "${DateTime.now().toIso8601String()}", 0, 1)',
        );
      },
      version: 5,
    );
  }

  static Future<List<Map<String, dynamic>>> loadTable(String table) async {
    final db = await Databaseutil.database();

    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> loadPerPerson(
    String table,
    String personId,
  ) async {
    final db = await Databaseutil.database();

    return db.query(
      table,
      where: 'personId = ?',
      whereArgs: [personId],
      orderBy: 'createdAt',
    );
  }

  static Future<List<Map<String, dynamic>>> loadSingle(
    String table,
    String id,
  ) async {
    final db = await Databaseutil.database();

    return db.query(table, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await Databaseutil.database();

    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> update(
    String table,
    Map<String, dynamic> data,
    String id,
  ) async {
    final db = await Databaseutil.database();

    await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> delete(String table, String id) async {
    final db = await Databaseutil.database();

    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deletePerPerson(String table, String id) async {
    final db = await Databaseutil.database();

    await db.delete(table, where: 'personId = ?', whereArgs: [id]);
  }
}
