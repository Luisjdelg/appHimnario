import 'package:apphimnario/model/author-model.dart';
import 'package:flutter/material.dart';

import '../../model/song-model.dart';


class SongsCard extends StatelessWidget {
  final SongModel song;
  final AuthorModel authors;
  final VoidCallback? press; // Good
  const SongsCard({
    Key? key,
    required this.song,
    required this.authors,
    required this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: press,
        title: Text(song.titleSong),

        //subtitle: Text(song.noteSong.toString()),
        subtitle: Text('${authors.nameAuthor} - ${song.noteSong.toString()}'),
        leading: Icon(Icons.music_video),
        trailing: Icon(Icons.arrow_forward_ios_sharp));
  }
}
