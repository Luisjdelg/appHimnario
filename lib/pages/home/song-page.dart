import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getSongData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: Text("kambak-himnario"),),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children:  [
                      const SizedBox(
                        width: 0,
                      ),

                      //para mostrar los appis consumidos
                      Consumer<MyProvider>(
                        builder: (context, value, child) {
                          if(value.songModel.isNotEmpty){
                            print(value.songModel);
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.songModel.length,
                                  itemBuilder: (context, item){
                                    //value.songModel[item].titleSong
                                    return Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                           ListTile(
                                            leading: Icon(Icons.music_video),
                                            title: Text(value.songModel[item].titleSong),
                                            subtitle: Text(value.songModel[item].noteSong),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                child: const Text('ingresa'),
                                                onPressed: () {/* ... */},
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                child: const Text('escuchar'),
                                                onPressed: () {/* ... */},
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          }
                          return const Center();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
