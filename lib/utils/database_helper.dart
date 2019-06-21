import "package:sqflite/sqflite.dart";
import "dart:async";
import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:learnv2/models/note.dart";

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = "note_table";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'new_notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: this._createDb);

    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

// fetch
    var result = await db
        .rawQuery("SELECT * FROM $noteTable ORDER BY $colPriority ASC"); // v1
//    var result = await db.query(noteTable, orderBy: "$colPriority ASC"); // v2
    return result;
  }

// insert
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    Map<String, dynamic> noteMap = note.toMap();
    int result = await db.insert(noteTable, noteMap);
    return result;
  }

// update
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    int result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

// delete
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
    return result;
  }

// get
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT (*) from $noteTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await this.getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();
    for(int i = 0; i < count; ++i) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
