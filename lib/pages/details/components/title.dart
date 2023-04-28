import 'package:apphimnario/model/author-model.dart';
import 'package:flutter/material.dart';
import 'package:apphimnario/constants.dart';
import '../../../model/song-model.dart';
class TitleSong extends StatelessWidget {
  const TitleSong({
    Key? key,
    required this.song,

  }) : super(key: key);

  final SongModel song;



  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin, horizontal: kDefaultPaddin),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            song.titleSong,


           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: kDefaultTitle),  //kDefaultTitle
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(song.noteSong,  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),

        ],
      ),
    );
  }
}
