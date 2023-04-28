import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditionPage extends StatefulWidget {
  const EditionPage({Key? key}) : super(key: key);

  @override
  State<EditionPage> createState() => _EditionPageState();
}

class _EditionPageState extends State<EditionPage> {

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
                          if(value.editionModel.isNotEmpty){
                            print(value.editionModel.isNotEmpty);
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.editionModel.length,
                                  itemBuilder: (context, item){
                                    return Card(
                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        child: Text(value.editionModel[item].nameEdition),),
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
