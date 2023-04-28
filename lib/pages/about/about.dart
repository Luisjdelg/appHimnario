import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import '../../../constants.dart';

class AboutScreen extends StatelessWidget {
  Future<void> shareAplication() async {
    await FlutterShare.share(
        title: "Descarga la apliación: ",
        text: "Descarga la apliación: ",
        linkUrl: 'https://tidecs.com/',
        chooserTitle: 'Himnario Kichwa');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Acerca de la Aplicación"),
              Expanded(child: Container()),
              IconButton(icon: Icon(Icons.share), onPressed: shareAplication,),

            ],
          ),
          //backgroundColor: themeColor,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: const Text(
            "La aplicación Kambak Himnario recopila himnos y alabanzas de coros, solistas y grupos de música cristiana clasificadas por evento, autor y ritmo. \n"
                "Esta aplicación es totalmente gratuita y se lo realizó con el objetivo de facilitar la dirección y animación en los eventos especiales, cultos, vigilias y campaña. "
                "Fue desarrollada por Luis Julio Delgado Taday, en conjunto con la Iglesia Compañía de Jesús. \n\n AGRADECIMIENT0 \n\n"
                "Quiero de todo corazón agradecer al rey de reyes, Señor de señores y al "
                "maestro salvador y el Señor Jesucristo. Por dar la oportunidad de seleccionar este canciones cristiano de muchos canta autor, interpretes, músicos, coros,danzas, dúo, solistas y consiervos. Los cuales brotan de un corazón transformado y "
                "renovado por el poder y amor de Dios. En especial a los autores coros.\n"
                "-DIOS NUCANCHIHUAN - HIJAS DE REY - CELESTIAL - LASSO-"
                "-INSPIRACION-ASITINBAY-VISION-MARCOS WIT-ELOHIM-"
                "- TRIO REY DAVID AMASHIYA ESTRELLITA GETSEMANI"
                "-HIJAS DE SION - LINAJE- DORDERO DE DIOS - TRINIDAD"
                "- MANATIAL CANTORAS DE SION - CANTARES SALMO 150 ",


            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ));


  }
}
