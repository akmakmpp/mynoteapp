// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
import 'dart:developer';

import 'package:mynote/modals/not_obj.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class NoteDatabase {
  static const dbName = 'my_note.db';
  static const tbName = 'noteDb';
  static const dbVersion = 1;
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnNote = 'note';
  static const columnDate = 'creatat';
  static const columnFavourite = 'favourite';
  static const columnTrash = 'trash';

  NoteDatabase._privateConstructor();

  static final NoteDatabase instance = NoteDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String dataPath = p.join(dbPath, dbName);

    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = p.join(documentsDirectory.path, dbName);

    return await openDatabase(dataPath,
        version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tbName(
	  $columnId INTEGER PRIMARY KEY
  , $columnTitle  TEXT 
  ,$columnNote TEXT      
  ,$columnDate  VARCHAR(20)
  ,$columnFavourite INT NOT NULL DEFAULT 0
  ,$columnTrash INT NOT NULL DEFAULT 0
 
);
          ''');
  }

  Future<int> insert(Map<String, dynamic> noteRow) async {
    Database db = await instance.database;

    return await db.insert(tbName, noteRow,
        conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: "");
  }

  Future<List<NoteObj>> queryAllRows() async {
    Database db = await instance.database;
    final data =
        await db.query(tbName, where: '$columnTrash = ?', whereArgs: [0]);
    log("queryAllRows" + data.toString());
    final List<NoteObj> noteList =
        data.map<NoteObj>((e) => NoteObj.fromJson(e)).toList();

    // for (var map in data) {
    //   noteList.add(NoteObj.fromJson(map));
    // }

    log("queryAllRows" + noteList.toString());
    return noteList;
  }

  Future updateNotebyID(
      int id, String title, String note, String creatat) async {
    //Get a reference to the database.
    Database db = await instance.database;
    log(id.toString());
    //Update the given Note.
    return await db.rawUpdate(
        'UPDATE $tbName SET $columnTitle = ?, $columnNote = ?, $columnDate = ? where $columnId = ?',
        [title, note, creatat, id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    log("db  " + db.toString());
    return await db.delete(tbName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<NoteObj>> queryAllFavouriteRow() async {
    Database db = await instance.database;
    final data =
        await db.query(tbName, where: '$columnFavourite =?', whereArgs: [1]);
    log('queryAllFavouriteRow' + data.toString());
    final List<NoteObj> noteList = [];
    for (var map in data) {
      noteList.add(NoteObj.fromJson(map));
    }
    return noteList;
  }

  Future<void> favoriteFunction(int value, int idx) async {
    Database db = await instance.database;
    await db.rawUpdate(
        'UPDATE $tbName SET $columnFavourite = ? where $columnId = ?',
        [value, idx]);
  }

  Future<List<NoteObj>> queryAllTrashRow() async {
    Database db = await instance.database;
    final data =
        await db.query(tbName, where: '$columnTrash =?', whereArgs: [1]);
    log('queryAllTrashRow' + data.toString());
    final List<NoteObj> noteList = [];
    for (var map in data) {
      noteList.add(NoteObj.fromJson(map));
    }
    return noteList;
  }

  Future<void> trashFunction(int value, int idx) async {
    Database db = await instance.database;
    await db.rawUpdate(
        'UPDATE $tbName SET $columnTrash = ? where $columnId = ?',
        [value, idx]);
  }

  Future<Map<String, Object?>> selectRowById(int id) async {
    Database db = await instance.database;
    log("db" + db.toString());
    var result =
        await db.query(tbName, where: '$columnId = ?', whereArgs: [id]);

    log("result" + result.toString());
    if (result.isNotEmpty) {
      return result[0];
    } else {
      throw Exception("Empty Result");
    }
  }

  Future deleleAll() async {
    Database db = await instance.database;
    return await db.delete(tbName);
  }
}
