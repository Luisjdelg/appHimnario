import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:apphimnario/pages/details/details-song.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/song-model.dart';
import 'item.dart';

class SearchBox extends SearchDelegate<SongModel> {
  List<SongModel> _filter = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    List<SongModel> songs= Provider.of<MyProvider>(context).songModel;

    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
// returna la lista buscada
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsSong(
                  song: _filter[index],
                ),
              ),
            ),
            leading: Icon(Icons.music_video),
            title: Text(_filter[index].titleSong),
            subtitle: Text(_filter[index].noteSong),
            trailing: Icon(Icons.arrow_forward_ios),

          ),
        );


  }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SongModel> songs= Provider.of<MyProvider>(context).songModel;

    _filter = songs.where((element) {
      return element.titleSong.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    // returna la lista sijerida mietras escribo
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsSong(
                  song: _filter[index],
                ),
              ),
            ),
            leading: Icon(Icons.music_video),
            title: Text(_filter[index].titleSong),
            subtitle: Text(_filter[index].noteSong),
            trailing: Icon(Icons.arrow_forward_ios),

          ),
        );
      },
    );
  }
}