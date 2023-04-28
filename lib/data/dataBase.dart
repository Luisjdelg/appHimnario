import 'dart:async';
import 'package:apphimnario/model/event-model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbManager {
  late Database _database;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE model(id INTEGER PRIMARY KEY autoincrement, fruitName TEXT, quantity TEXT)",
          );
        });
    return _database;
  }

  Future insertModel(EventModel model) async {
    await openDb();
    return await _database.insert('model', model.toJson());
  }

  Future<List<Model>> getModelList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('model');

    return List.generate(maps.length, (i) {
      return Model(
          id: maps[i]['id'],
          fruitName: maps[i]['quantity']);
    });
    // return maps
    //     .map((e) => Model(
    //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
    //     .toList();
  }

  Future<int> updateModel(EventModel model) async {
    await openDb();
    return await _database.update('model', model.toJson(),
        where: "id = ?", whereArgs: [model.idEvent]);
  }

  Future<void> deleteModel(EventModel model) async {
    await openDb();
    await _database.delete('model', where: "id = ?", whereArgs: [model.idEvent]);
  }
}
