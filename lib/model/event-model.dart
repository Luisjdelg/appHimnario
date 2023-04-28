import 'dart:convert';

List<EventModel> eventFromJson(String str) => List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));
String eventsModelToJson(List<EventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventModel {
  EventModel({
    required this.idEvent,
    required this.nameEvent,
  });

  int idEvent;
  String nameEvent;
  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    idEvent: int.parse(json["id_event"]),
    nameEvent: json["name_event"],
  );

  Map<String, dynamic> toJson() => {
    "id_event": idEvent,
    "name_event": nameEvent,
  };
  Map<String,dynamic> toMap(){
    return {
      'idEvent': idEvent,
      'nameEvent': nameEvent,
    };
  }
}

