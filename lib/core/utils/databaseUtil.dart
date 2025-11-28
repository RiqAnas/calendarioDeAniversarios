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
          'CREATE TABLE persons (id TEXT PRIMARY KEY, nome TEXT NOT NULL, nascimento TEXT NOT NULL, idade INTEGER, ativa INTEGER NOT NULL)',
        );

        await db.execute(
          'CREATE TABLE notes (id TEXT PRIMARY KEY, personId TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL, mark INTEGER NOT NULL, marked INTEGER, date TEXT, FOREIGN KEY (personId) REFERENCES persons (id))',
        );
      },
      version: 2,
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

    return db.query(table, where: 'personId = ?', whereArgs: [personId]);
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

    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
