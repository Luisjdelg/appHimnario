
import 'package:apphimnario/data/http-services.dart';
import 'package:apphimnario/model/author-model.dart';
import 'package:apphimnario/model/edition-model.dart';
import 'package:apphimnario/model/song-model.dart';
import 'package:apphimnario/model/event-model.dart';
import 'package:apphimnario/model/swing-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyProvider extends ChangeNotifier{
  List<SongModel> songModel = [];
  List<SongModel> filtroSongs = [];

  List<EventModel> eventModel = [];
  List<SwingModel> swingModel = [];
  List<AuthorModel> authorModel = [];
  List<EditionModel> editionModel =[];

  HttpService songHttpService = HttpService();
  HttpService eventHttpService = HttpService();
  HttpService swingHttpService = HttpService();
  HttpService authorHttpService = HttpService();
  HttpService editionHttpService = HttpService();
  late Database _database;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE model(id INTEGER PRIMARY KEY autoincrement, fruitName TEXT)",
          );
        });
    return _database;
  }
  void getSongData() async{
    songModel = await songHttpService.getSongs();
    notifyListeners();
  }
  void getSongsData(int id_event, String tipo) async{
     if(tipo=="Evento"){
      songModel = await songHttpService.getSongs();
      //
      filtroSongs = [];
      for (var song in songModel) {
        if (id_event == 0) {
          print(" aqui cero "+id_event.toString() );
          filtroSongs.add(song);
        } else {
          print(id_event.toString() + "==" + song.id_eventSong.toString());
          if (id_event ==song.id_eventSong) {


            filtroSongs.add(song);
          }
        }
      }
    }
    else if (tipo=="Edicion"){
      songModel = await songHttpService.getSongs();
      filtroSongs = [];
      for (var song in songModel) {
        if (id_event == 0) {
          filtroSongs.add(song);
        } else {
          if (id_event ==song.id_editionSong) {
            filtroSongs.add(song);
          }
        }
      }
    } else if (tipo=="Autor"){
      songModel = await songHttpService.getSongs();
      filtroSongs = [];
      for (var song in songModel) {
        if (id_event == 0) {
          filtroSongs.add(song);
        } else {
          if (id_event ==song.id_authorSong) {
            filtroSongs.add(song);
          }
        }
      }
    }
    notifyListeners();
  }
  void getEventData() async{
    eventModel = await eventHttpService.getEvents();
    notifyListeners();
  }
  void getEventDatas() async{
    eventModel = await eventHttpService.getEvents();
    notifyListeners();
  }

  void getSwingData() async{
    swingModel = await swingHttpService.getSwing();
  }
  void getAuthorData() async{
    authorModel = await authorHttpService.getAuthor();
  }
  void getEditionData() async{
    editionModel = await editionHttpService.getEdition();
  }


}
class ShareApp {

  Future<void> shareAplication() async {
    await FlutterShare.share(
        title: "Descarga la apliación: ",
        text: "Descarga la apliación: ",
        linkUrl: 'https://play.google.com/store/apps/details?id=com.himnario.apphinminario',
        chooserTitle: 'Himnario Kichwa');
    print("msg");

  }
}

