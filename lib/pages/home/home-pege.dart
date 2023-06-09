

import 'dart:async';

import 'package:apphimnario/data/dataBase.dart';
import 'package:apphimnario/model/event-model.dart';
import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:apphimnario/pages/config/config-page.dart';
import 'package:apphimnario/pages/details/details-song.dart';
import 'package:apphimnario/pages/home/research-box.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apphimnario/constants.dart';
import 'package:apphimnario/pages/about/about.dart';
import '../../myprovider/DBProvider.dart';

const List<String> list = <String>['Evento', 'Autor', 'Edicion', 'Ritmo'];
String model="Evento";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbManager dbManager = new DbManager();
  late EventModel models;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        print("Hay internet");
        Provider.of<MyProvider>(context, listen: false).sincronizarEvents();
        Provider.of<MyProvider>(context, listen: false).sincronizarSongs();
        Provider.of<MyProvider>(context, listen: false).getSongsData(0,model);

      }else{
        print("No hay internet");
        Provider.of<MyProvider>(context, listen: false).getSongsData(0,model);
        DBProvider.bd.getAllEvents();
      }
    });
  }
  String dropdownValue=model;
  int selectedIndex = 0;
// crea un widget del tipo scaffol

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kambak-himnario"),
        actions: [

          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
              onPressed: () async {
              },
              child:        DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    model=value;
                    selectedIndex=0;
                    Provider.of<MyProvider>(context, listen: false).sincronizarSongs();
                    Provider.of<MyProvider>(context, listen: false).sincronizarEvents();
                    Provider.of<MyProvider>(context, listen: false).getSongsData(0,model);
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black54),),
                  );
                }).toList(),
              ),
            ),
          ),
        ],

      ),
      drawer: Drawer(child: drawerMenu(context)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 4.0 / 4, // 5 top and bottom
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  trailing: const Icon(
                    Icons.search,
                    //color: themeColor,
                  ),
                  title: const Text(
                    "Buscar",
                  ),
                  onTap: () {
                     showSearch(context: context, delegate: SearchBox());
                  },
                )),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 30,
              child: FutureBuilder<List<EventModel>>(
                future: DBProvider.bd.getAllEvents(),
                builder: (BuildContext context,AsyncSnapshot<List<EventModel>> snapshot) {
                  print("paso1");
                  if (snapshot.hasData) {
                    List<EventModel> modelList = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: modelList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            Provider.of<MyProvider>(context, listen: false)
                                .getSongsData(index,"Evento");
                          }
                          );

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPaddin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /** decoracion del botones de eventos**/
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.white70,
                                  //color: provider.[index].id == index ? Colors.yellow : Colors.blue,
                                ),
                                child: Text(
                                  modelList[index].nameEvent,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: modelList[index].idEvent ==
                                        index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  );
                },
              ),
            ),
          ),
          // consume del proveedor y construye una lista segun los datos

          Consumer<MyProvider>(
            builder: (context, value, child) {
              if (value.filtroSongs.isNotEmpty) { // si el value no viene vacio
                return Expanded(
                    child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: value.filtroSongs.length,
                  itemBuilder: (context, item) {
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsSong(
                              song: value.filtroSongs[item],
                            ),
                          ),
                        ),
                        leading: Icon(Icons.music_video),
                        title: Text(value.filtroSongs[item].titleSong),
                        subtitle: Text(value.filtroSongs[item].noteSong),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );

  }
  Widget drawerMenu(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
            child: Image(image: AssetImage("assets/images/logob.png")),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline_rounded,
          ),
          title: const Text('Acerca de la aplicación'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.settings,

          ),
          title: const Text('Ajustes'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConfigPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.star_border,

          ),
          title: const Text('Calificar'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.share,

          ),
          title: const Text('Compartir'),
          onTap: () => context<ShareApp>().shareAplication(),

        ),
        /* ListTile(
          leading: const Icon(
            Icons.warning_amber,

          ),
          title: const Text('Notificar Error'),
          onTap: () {
            Navigator.pop(context);
          },
        ),*/
        const ListTile(
          subtitle: Text('Redes sociales'),
        ),
        ListTile(
          leading: const Icon(
            Icons.facebook,
          ),
          title: const Text('Facebook'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.web,
          ),
          title: const Text('Página Web'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}


