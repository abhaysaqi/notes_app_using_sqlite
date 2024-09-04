import 'package:notes_app/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._internal();
  static final DatabaseProvider db = DatabaseProvider._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) async => await db.execute(
            """ CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, dateTime DATE)"""),
        version: 1);
  }

  addnewNote(NoteModel note) async {
    final db = await database;
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieves a list of notes from the database.
  //
  // Returns a list of notes if the database is not empty, otherwise returns null.
  Future<dynamic> getNotes() async {
    final db = await database
      ..query('table');
    var res = await db.query("notes");
    return res.isNotEmpty ? res.toList() : null;
    // if (res.isEmpty) {
    //   return null;
    // } else {
    //   var resultMap = res.toList();
    //   return resultMap.isNotEmpty? resultMap : null;
    // }
  }

  Future<int> deleteRow({required int id}) async {
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = $id");
    return count;
  }
}
