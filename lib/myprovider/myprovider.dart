
import 'dart:convert';

import 'package:apphimnario/data/http-services.dart';
import 'package:apphimnario/model/author-model.dart';
import 'package:apphimnario/model/edition-model.dart';
import 'package:apphimnario/model/song-model.dart';
import 'package:apphimnario/model/event-model.dart';
import 'package:apphimnario/model/swing-model.dart';
import 'package:apphimnario/myprovider/DBProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

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
          filtroSongs.add(song);
        } else {
         // print(id_event.toString() + "==" + song.id_eventSong.toString());
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

  void getSwingData() async{
    swingModel = await swingHttpService.getSwing();
  }
  void getAuthorData() async{
    authorModel = await authorHttpService.getAuthor();
  }
  void getEditionData() async{
    editionModel = await editionHttpService.getEdition();
  }


  void sincronizarEvent() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/event");
    var response = await http.get(uri);
    print("response"+response.body);
    var dataEvent;
    print("response.statusCode"+response.statusCode.toString());

    if (response.statusCode == 200) {
      print("entrando");

      dataEvent = eventFromJson(response.body);
      //eventFromJson(response.body);

      for (int i = 0; i < dataEvent.length; i++) {
        await DBProvider.bd.newEvent(new EventModel(
            idEvent: dataEvent[i]["id_event"],
            nameEvent: dataEvent[i]["name_event"]
        ));
      }
    }

  }

  void sincronizarEvents() async {
    var dataMeasurer;

    var uri = Uri.parse("https://himnario.kambakfruta.com/api/event");
    var data = await http.get(uri);
    print("response"+data.body);
    var dataEvent;
    print("response.statusCode"+data.statusCode.toString());
    if (data.statusCode == 200) {
      dataMeasurer = json.decode(data.body);
      for (int i = 0; i < dataMeasurer.length; i++) {
        await DBProvider.bd.newEvent(new EventModel(
          idEvent: int.parse(dataMeasurer[i]["id_event"]),
          nameEvent: dataMeasurer[i]["name_event"],
        ));
      }
    }
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

