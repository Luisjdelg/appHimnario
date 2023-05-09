import 'dart:io';
import 'package:apphimnario/model/event-model.dart';
import 'package:apphimnario/model/song-model.dart';
import 'package:apphimnario/model/swing-model.dart';
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
    String path = join(documentsDirectory.path, "himn.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute("CREATE TABLE event ("
        "id_event INTEGER PRIMARY KEY NOT NULL,"
        "name_event VARCHAR(50) NOT NULL)");
    await db.execute("CREATE TABLE swing ("
        "id_swing INTEGER PRIMARY KEY NOT NULL,"
        "name_swing VARCHAR(50) NOT NULL)");
    await db.execute("CREATE TABLE song ("
        "id_song INTEGER PRIMARY KEY NOT NULL,"
        "title_song VARCHAR(100) NOT NULL,"
        "note_song VARCHAR(50) NOT NULL,"
        "description_song VARCHAR(3000) NOT NULL,"
        "id_event INTEGER NOT NULL,"
        "id_swing INTEGER NOT NULL,"
        "id_author INTEGER NOT NULL,"
        "id_edition INTEGER NOT NULL)");
  }
  // evento
  newEvent(EventModel newEvent) async {
    final db = await database;
    var orgRoute = 0;
//    var res = await db!.insert("event", newEvent.toMap());
    int res = await db!.rawUpdate(
        "UPDATE event SET name_event = ? WHERE id_event = ?",
        [newEvent.nameEvent, newEvent.idEvent]
    );
    if (res == 0) {
      // El registro no existía previamente, se inserta uno nuevo
      res = await db.rawInsert(
          "INSERT INTO event (id_event,name_event)"
              " VALUES (${newEvent.idEvent},'${newEvent.nameEvent}')");
    }
    return res;
    /*int res = await db!.update(
        "event",
        newEvent.toMap(),
        where: "id_event = ?",
        whereArgs: [newEvent.idEvent]
    );
    if (res == 0) {
      // El registro no existía previamente, se inserta uno nuevo
      res = await db.insert("event", newEvent.toMap());
    }
    return res;*/
    /*
    var res = await db!.rawInsert(
        "INSERT INTO event (id_event,name_event)"
            " VALUES (${newEvent.idEvent},'${newEvent.nameEvent}')");
    return res;

     */
  }

  Future<List<EventModel>> getAllEvents() async {
    final db = await database;
    var response = await db!.query("event");
    List<EventModel> list;
    if (response.isNotEmpty) {
      list = response.map((c) => EventModel.fromMap(c)).toList();
    } else {
      list = [];
    }
    return list;
  }
  // Swing
  newSwing(SwingModel newSwing) async {
    final db = await database;
//    var res = await db!.insert("swing", newSwing.toMap());
    var res = await db!.rawInsert(
        "INSERT Into swing (id_swing,name_swing)"
            " VALUES (${newSwing.idSwing},'${newSwing.nameSwing}')");
    return res;
  }

  Future<List<SwingModel>> getAllSwings() async {
    final db = await database;
    var response = await db!.query("swing");
    List<SwingModel> list;
    if (response.isNotEmpty) {
      print("llenando");
      list = response.map((c) => SwingModel.fromMap(c)).toList();
    } else {
      print("vacio");
      list = [];
    }
    return list;
  }
  // Song
  newSong(SongModel newSong) async {
    final db = await database;
    var orgRoute = 0;
    int res = await db!.rawUpdate(
        "UPDATE song SET title_song = ?, note_song = ?, description_song = ?, id_event = ?, id_swing = ?, id_author = ?, id_edition = ? WHERE id_song = ?",
        [newSong.titleSong, newSong.noteSong, newSong.descriptionSong, newSong.id_eventSong, newSong.id_swingSong, newSong.id_authorSong, newSong.id_editionSong, newSong.idSong]
    );
    if (res == 0) {
      // El registro no existía previamente, se inserta uno nuevo
      res = await db.rawInsert(
          "INSERT Into song (id_song,title_song,note_song,description_song,id_event,id_swing,id_author,id_edition)"
              " VALUES (${newSong.idSong},'${newSong.titleSong}','${newSong.noteSong}','${newSong.descriptionSong}',${newSong.id_eventSong},${newSong.id_swingSong},${newSong.id_authorSong},${newSong.id_editionSong})");

    }
    return res;

  }

  Future<List<SongModel>> getAllSongs() async {
    final db = await database;
    var response = await db!.query("song");
    List<SongModel> list;
    if (response.isNotEmpty) {
      list = response.map((c) => SongModel.fromMap(c)).toList();
    } else {
      list = [];
    }
    return list;
  }

}