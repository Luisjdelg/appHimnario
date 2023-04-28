
import 'package:flutter/material.dart';
import '../../../model/song-model.dart';
import 'package:apphimnario/constants.dart';

class DescriptionSong extends StatelessWidget {
  const DescriptionSong({
    Key? key,
    required this.song,
  }) : super(key: key);
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900.0,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin, horizontal: kDefaultPaddin),
      alignment: Alignment.topLeft,
      child: Text(
          song.descriptionSong
      ),
          );
  }
}
