import 'dart:convert';

List<SwingModel> swingFromJson(String str) => List<SwingModel>.from(json.decode(str).map((x) => SwingModel.fromJson(x)));
String swingsModelToJson(List<SwingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwingModel {
  SwingModel({
    required this.idSwing,
    required this.nameSwing,
  });

  int idSwing;
  String nameSwing;
  factory SwingModel.fromJson(Map<String, dynamic> json) => SwingModel(
    idSwing: json["id_swing"],
    nameSwing: json["name_swing"],
  );
  factory SwingModel.fromMap(Map<String, dynamic> json) => SwingModel(
      idSwing: json["id_swing"],
      nameSwing: json["name_swing"]
  );

  Map<String, dynamic> toJson() => {
    "id_swing": idSwing,
    "name_swing": idSwing,
  };
}