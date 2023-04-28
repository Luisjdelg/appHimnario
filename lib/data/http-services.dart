import 'package:apphimnario/model/author-model.dart';
import 'package:apphimnario/model/edition-model.dart';
import 'package:http/http.dart' as http;
import 'package:apphimnario/model/song-model.dart';
import 'package:apphimnario/model/event-model.dart' ;
import 'package:apphimnario/model/swing-model.dart';


class HttpService{
  Future<List<EventModel>> getEvents() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/event");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      return eventFromJson(response.body);
    }else{
       return eventFromJson(response.body);
        }
      }
  
  Future<List<SongModel>> getSongs() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/song");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      return songFromJson(response.body);
    }else{
      return songFromJson(response.body);
    }
  }
  Future<List<SwingModel>> getSwing() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/swing");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      return swingFromJson(response.body);
    }else{
      return swingFromJson(response.body);
    }
  }
  Future<List<AuthorModel>> getAuthor() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/author");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      return authorFromJson(response.body);
    }else{
      return authorFromJson(response.body);
    }

  }
  Future<List<EditionModel>> getEdition() async {
    var uri = Uri.parse("https://himnario.kambakfruta.com/api/edition");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      return editionFromJson(response.body);
    }else{
      return editionFromJson(response.body);
    }
  }

     }
