// import 'package:madicalapp_ui/Services/model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
//
// class DataBaseServices {
//   static Database? _db;
//   static DataBaseServices instance = DataBaseServices._constructor();
//   final String _tasksTableName = 'tasks';
//   final String _tasksIdColumnName = 'id';
//   final String _tasksContentColumnName = 'content';
//   final String _tasksStatusColumnName = 'status';
//   DataBaseServices._constructor();
//
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await getDatabase();
//     return _db!;
//   }
//
//   Future<Database> getDatabase() async {
//     final databaseDirPath = await getDatabasesPath();
//     final databasePath = join(databaseDirPath, 'master_db.db');
//     final database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) async {
//         print("Creating table $_tasksTableName");
//         await db.execute('''
//         CREATE TABLE $_tasksTableName(
//           $_tasksIdColumnName INTEGER PRIMARY KEY,
//           $_tasksContentColumnName TEXT NOT NULL,
//           $_tasksStatusColumnName INTEGER NOT NULL
//         )
//         ''');
//       },
//       onOpen: (db) {
//         print("Database opened");
//       },
//     );
//     return database;
//   }
//
//   Future<void> addTask(String content) async {
//     Database db = await database;
//     await db.insert(
//       _tasksTableName,
//       {
//         _tasksContentColumnName: content,
//         _tasksStatusColumnName: 0,
//       },
//     );
//     print("Task added: $content");
//   }
//
//   Future<List<Task>> getTasks() async {
//     final db = await database;
//     final data = await db.query(_tasksTableName);
//     print('------------->$data');
//     return data.map((e) => Task.fromMap(e)).toList();
//   }
// }

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,age INTEGER NOT NULL, description TEXT NOT NULL, email TEXT)",
    );
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future deleteTableContent(NotesModel notesModel) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [notesModel.id]
    );
  }

  Future<int> updateQuantity(NotesModel notesModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'notes',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
