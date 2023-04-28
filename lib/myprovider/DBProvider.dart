import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../model/event-model.dart';

class DBProvider {
  static final DBProvider instance = DBProvider._init();
  //static Database? _database;
  DBProvider._init();

  //DBProvider._();
  //static final DBProvider bd = DBProvider._();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "himnario.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute("CREATE TABLE event ("
        "id_event INTEGER PRIMARY KEY autoincrement NOT NULL,"
        "name_event VARCHAR(50) NOT NULL");
  }

  newEventModel(EventModel newEventModel) async {
    final db = await database;

    var orgRoute = 0;

    // var res = await db.insert("EventModels", newEventModel.toMap());

    var res = await db.rawInsert(
        "INSERT INTO event (nameEvent)"
            " VALUES (?)",
        [
          newEventModel.nameEvent,

          orgRoute
        ]);

    return res;
  }
  /*
  getAllClients() async {
    final db = await _database;
    var res = await db.query("Client");
    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

   */
  Future<List<EventModel>> getAllItems() async {


    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query("table");
    print("length"+maps.toString());

    return List.generate(maps.length, (i) {
      return EventModel(
          idEvent: maps[i]['id_event'],
          nameEvent: maps[i]['name_event']
      );
    });
  }

}