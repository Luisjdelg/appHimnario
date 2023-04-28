import 'dart:convert';

List<AuthorModel> authorFromJson(String str) => List<AuthorModel>.from(json.decode(str).map((x) => AuthorModel.fromJson(x)));
String authorModelToJson(List<AuthorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorModel {
  AuthorModel({
    required this.idAuthor,
    required this.nameAuthor,
});
  String idAuthor;
  String nameAuthor;
  factory AuthorModel.fromJson(Map< String, dynamic >json) => AuthorModel(
      idAuthor: json["id_author"],
      nameAuthor: json["name_author"],
  );
  Map<String, dynamic> toJson() =>{
    "id_author": idAuthor,
    "name_author": nameAuthor,
  };
}