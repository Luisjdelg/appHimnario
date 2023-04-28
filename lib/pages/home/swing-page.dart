import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwingPage extends StatefulWidget {
  const SwingPage({Key? key}) : super(key: key);

  @override
  State<SwingPage> createState() => _SwingPageState();
}

class _SwingPageState extends State<SwingPage> {

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getSwingData();
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
                          if(value.swingModel.isNotEmpty){
                            print(value.swingModel.isNotEmpty);
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.swingModel.length,
                                  itemBuilder: (context, item){
                                    return Card(
                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        child: Text(value.swingModel[item].nameSwing),),
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
