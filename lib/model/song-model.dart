import 'dart:convert';

List<SongModel> songFromJson(String str) => List<SongModel>.from(json.decode(str).map((x) => SongModel.fromJson(x)));
String songModelToJson(List<SongModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class SongModel {
  SongModel({
    required this.idSong,
    required this.titleSong,
    required this.noteSong,
    required this.descriptionSong,
    required this.id_eventSong,
    required this.id_swingSong,
    required this.id_authorSong,
    required this.id_editionSong,

  });

  int idSong;
  String titleSong;
  String noteSong;
  String descriptionSong;
  int id_eventSong;
  int id_swingSong;
  int id_authorSong;
  int id_editionSong;


  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    idSong:  int.parse(json["id_song"]),
    titleSong: json["title_song"],
    noteSong: json["note_song"],
    descriptionSong: json["description_song"],
    id_eventSong: int.parse(json["id_event"]),
    id_swingSong: int.parse(json["id_swing"]),
    id_authorSong: int.parse(json["id_author"]),
    id_editionSong: int.parse(json["id_edition"]),
  );

  factory SongModel.fromMap(Map<String, dynamic> json) => SongModel(
      idSong: json["id_song"],
      titleSong: json["title_song"],
      noteSong: json["note_song"],
      descriptionSong: json["description_song"],
      id_eventSong: json["id_event"],
      id_swingSong: json["id_swing"],
      id_authorSong: json["id_author"],
      id_editionSong: json["id_edition"]
  );

  Map<String, dynamic> toJson() => {
    "id_song": idSong,
    "title_song": titleSong,
   "note_song":  noteSong,
    "description_song": descriptionSong,
    "id_event": id_eventSong,
    "id_swing": id_swingSong,
    "id_author": id_authorSong,
    "id_edition": id_editionSong,
  };


}