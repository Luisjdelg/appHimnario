
import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {

  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getAuthorData();
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
                          if(value.authorModel.isNotEmpty){
                            print(value.authorModel.isNotEmpty);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.authorModel.length,
                                  itemBuilder: (context, item){
                                    return Card(
                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        child: Text(value.authorModel[item].nameAuthor),),
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