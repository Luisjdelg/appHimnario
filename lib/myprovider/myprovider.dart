
import 'dart:async';
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

  //////////////////////



  //////////////////////

  void getSongDatas() async{
    songModel = await songHttpService.getSongs();
    notifyListeners();
  }

  void getSongsData(int id_event, String tipo) async{
      filtroSongs = [];
      songModel=await DBProvider.bd.getAllSongs();
      for (var song in songModel) {
        if (id_event == 0) {
          filtroSongs.add(song);
        } else {
          if (id_event ==song.id_eventSong) {
            filtroSongs.add(song);
          }
        }
      }
    notifyListeners();
  }



  void getSongsDat(int id_event, String tipo) async{
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

  // sincronizacion para evento
  void sincronizarEvents() async {
    var dataEvent;
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/event");
    var data = await http.get(uri);
    if (data.statusCode == 200) {
      dataEvent = json.decode(data.body);
      for (int i = 0; i < dataEvent.length; i++) {
        await DBProvider.bd.newEvent(EventModel(
          idEvent: int.parse(dataEvent[i]["id_event"]),
          nameEvent: dataEvent[i]["name_event"],
        ));
      }
    }
    notifyListeners();
  }
  // sincronizacion para swing

  void sincronizarSwings() async {
    print("sincronisa la tabla swing");
    var dataSwing;
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/swing");
    var data = await http.get(uri);
    if (data.statusCode == 200) {
      dataSwing = json.decode(data.body);
      for (int i = 0; i < dataSwing.length; i++) {
        await DBProvider.bd.newSwing(SwingModel(
          idSwing: int.parse(dataSwing[i]["id_swing"]),
          nameSwing: dataSwing[i]["name_swing"],
        ));
      }
    }
  }

  // sincronizacion para song
  void sincronizarSongs() async {
    var dataSong;
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/song");
    var data = await http.get(uri);

    if (data.statusCode == 200) {
      dataSong = json.decode(data.body);
      for (int i = 0; i < dataSong.length; i++) {
        await DBProvider.bd.newSong(SongModel(
          idSong: int.parse(dataSong[i]["id_song"]),
          titleSong: dataSong[i]["title_song"],
          noteSong: dataSong[i]["note_song"],
          descriptionSong: dataSong[i]["description_song"],
          id_eventSong: int.parse(dataSong[i]["id_event"]),
          id_swingSong: int.parse(dataSong[i]["id_swing"]),
          id_authorSong: int.parse(dataSong[i]["id_author"]),
          id_editionSong: int.parse(dataSong[i]["id_edition"])
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

