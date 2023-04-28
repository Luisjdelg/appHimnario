
import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getEventData();
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
                          if(value.eventModel.isNotEmpty){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: value.eventModel.map((event) {
                                      return Card(
                                        child: Container(
                                          width: 150,
                                          padding: EdgeInsets.all(10),
                                          child:  Text(event.nameEvent),

                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Si eventModel está vacío, muestra un indicador de carga o un mensaje vacío.
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )
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
