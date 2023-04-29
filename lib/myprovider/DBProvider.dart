import 'dart:io';
import 'package:apphimnario/model/event-model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider bd = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Suspensions.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute("CREATE TABLE event ("
        "id_event INTEGER PRIMARY KEY NOT NULL,"
        "name_event VARCHAR(50) NOT NULL)");
  }

  newEvent(EventModel newEvent) async {
    final db = await database;

    var orgRoute = 0;

//    var res = await db!.insert("event", newEvent.toMap());
    print("insertando");
    print(newEvent.idEvent);
    print(newEvent.nameEvent);
    var res = await db!.rawInsert(
        "INSERT Into event (id_event,name_event)"
            " VALUES (${newEvent.idEvent},'${newEvent.nameEvent}')");
    return res;


  }

  Future<List<EventModel>> getAllClients() async {
    final db = await database;
    var res = await db!.query("event");


    List<EventModel> list;
    if (res.isNotEmpty) {
      print(res.length);

      list = res.map((c) => EventModel.fromMap(c)).toList();

    } else {
      list = [];
    }

    return list;
  }
}