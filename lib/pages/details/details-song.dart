import 'package:apphimnario/pages/details/components/description.dart';
import 'package:apphimnario/pages/details/components/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:apphimnario/constants.dart';
import '../../model/song-model.dart';
import 'components/description.dart';
import 'components/title.dart';

class DetailsSong extends StatelessWidget {
  final SongModel song;
  const DetailsSong(
      {Key? key, required this.song})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    TitleSong(song: song,),
                    DescriptionSong(song: song),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
  Future<void> share(TitleSong,  DescriptionSong, ) async {
    await FlutterShare.share(
        title: TitleSong,
        text: TitleSong+"\n \n"+ DescriptionSong+ "/""\n \n Descarga la aplicación: ",
        linkUrl: 'https://tidecs.com/',
        chooserTitle: 'Himnario Kichuwa');
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
          },
        ),
        IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
               share(song.titleSong, song.descriptionSong);
            }
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
