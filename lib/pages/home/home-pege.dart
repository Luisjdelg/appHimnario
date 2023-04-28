import 'package:apphimnario/data/dataBase.dart';
import 'package:apphimnario/data/localStorage/shop-data-base.dart';
import 'package:apphimnario/model/event-model.dart';
import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:apphimnario/pages/config/config-page.dart';
import 'package:apphimnario/pages/details/details-song.dart';
import 'package:apphimnario/pages/home/research-box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apphimnario/constants.dart';
import 'package:apphimnario/pages/about/about.dart';

const List<String> list = <String>['Evento', 'Autor', 'Edicion', 'Ritmo'];
String model="Evento";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DbManager dbManager = new DbManager();

  late Model model;
  late List<Model> modelList;
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  late FocusNode input1FocusNode;
  late FocusNode input2FocusNode;

  @override
  void initState() {
    input1FocusNode = FocusNode();
    input2FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    input1FocusNode.dispose();
    input2FocusNode.dispose();
    super.dispose();
  }
  Future<void> addToCart() async {
    final item = EventModel(
        idEvent: 5,
        nameEvent: "HOLA5"
    );

    await ShopDatabase.instance.insert(item);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite Demo'),
        actions: [

          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () async {
                  await addToCart();
                  print("clic buton");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Producto agregado!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Text("Filtrar", style:TextStyle(color: Colors.white)) ),),
        ],

      ),

      body: FutureBuilder(
        future: ShopDatabase.instance.getAllItems(),
        builder: (BuildContext context,AsyncSnapshot<List<EventModel>> snapshot) {
          print(snapshot.data);
          print(snapshot.hasData);

          if (snapshot.hasData) {

            List<EventModel> modelList = snapshot.data!;

            return ListView.builder(
              itemCount: modelList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(modelList[index].nameEvent),

                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


/*
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DbManager dbManager = new DbManager();
  late EventModel models;
  late List<EventModel> modelList;
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  late FocusNode input1FocusNode;
  late FocusNode input2FocusNode;

  /*
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();

  late List lists;
  bool loading = true;
  Future userList()async{
    lists = await Controller().fetchData();
    setState(() {loading=false;});
    print(list);
  }

  Future syncToMysql()async{
    await SyncronizationData().fetchAllInfo().then((userList)async{
      EasyLoading.show(status: 'Dont close app. we are sync...');
    });
  }

  Future isInteret()async{
    await SyncronizationData.isInternet().then((connection){
      if (connection) {

        print("Internet connection abailale");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet")));
      }
    });
  }


*/


  @override
  void initState() {
    input1FocusNode = FocusNode();
    input2FocusNode = FocusNode();
    super.initState();
    //userList();
    //isInteret();
    /*
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        print('tiempo');

        //_timer?.cancel();
      }
    });
    */



    Provider.of<MyProvider>(context, listen: false).getEventData();
    Provider.of<MyProvider>(context, listen: false).getEditionData();
    Provider.of<MyProvider>(context, listen: false).getAuthorData();
    Provider.of<MyProvider>(context, listen: false).getSongsData(0,model);
  }
  Future<void> addToCart() async {
    final item = EventModel(
        idEvent: "1",
        nameEvent: "HOLA"
    );
    await ShopDatabase.instance.insert(item);
  }
  @override
  void dispose() {
    input1FocusNode.dispose();
    input2FocusNode.dispose();
    super.dispose();
  }
  String dropdownValue=model;
  int selectedIndex = 0;
// crea un widget del tipo scaffold
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kambak-himnario"),
        actions: [
        DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            model=value;
            selectedIndex=0;
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
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: kDefaultPaddin ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
              onPressed: () async {
                await addToCart();
                print("clic buton");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Producto agregado!"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Text("Filtrar", style:TextStyle(color: Colors.white)) ),),
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
              child: Consumer<MyProvider>(builder: (context, provider, child) {
                //categorias(context,provider,child);
                if(model=="Edicion"){
                  if (provider.editionModel.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.editionModel.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            Provider.of<MyProvider>(context, listen: false)
                                .getSongsData(index,"Edicion");
                          });
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
                                  provider.editionModel[index].nameEdition,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: provider.editionModel[index].idEdition ==
                                        index
                                        ? Theme.of(context).secondaryHeaderColor
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
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: Colors.red,
                      ));
                }else if(model=="Evento"){
                  if (provider.eventModel.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.eventModel.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // print("evento:"+index.toString());

                          setState(() {
                            selectedIndex = index;
                            Provider.of<MyProvider>(context, listen: false)
                                .getSongsData(index,"Evento");
                          });
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
                                  provider.eventModel[index].nameEvent,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: provider.eventModel[index].idEvent ==
                                        index
                                        ? Theme.of(context).secondaryHeaderColor
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
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: Colors.red,
                      ));
                }else if(model=="Autor"){
                  if (provider.authorModel.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.authorModel.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // print("evento:"+index.toString());

                          setState(() {
                            selectedIndex = index;
                            Provider.of<MyProvider>(context, listen: false)
                                .getSongsData(index,"Autor");
                          });
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
                                  provider.authorModel[index].nameAuthor,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: provider.authorModel[index].idAuthor ==
                                        index
                                        ? Theme.of(context).secondaryHeaderColor
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
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: Colors.red,
                      ));
                }
                return const Center(
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: Colors.red,
                    ));
              }
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


 */
