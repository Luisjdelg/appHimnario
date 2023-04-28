import 'dart:convert';

import 'package:apphimnario/model/edition-model.dart';

List<EditionModel> editionFromJson(String str) => List<EditionModel>.from(json.decode(str).map((x) => EditionModel.fromJson(x)));
String editionModelToJson(List<EditionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditionModel {
  EditionModel({
    required this.idEdition,
    required this.nameEdition,
  });

  String idEdition;
  String nameEdition;
  factory EditionModel.fromJson(Map<String, dynamic> json) => EditionModel(
    idEdition: json["id_edition"],
    nameEdition: json["name_edition"],
  );

  Map<String, dynamic> toJson() => {
    "id_edition": idEdition,
    "name_edition": nameEdition,
  };
}