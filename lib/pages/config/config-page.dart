
import 'package:flutter/material.dart';

import 'components/theme-switch.dart';
import 'components/color-switch.dart';

class ConfigPage extends StatelessWidget {
  double raiting = 50.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
          width: 450.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ListTile(
                leading: Icon(Icons.format_color_fill),
                title: Text('Tamaño de letra:'),
              ),
              const Divider(),
              Slider(
                  value: raiting,
                  min: 0,
                  max: 100,
                  onChanged: (newRaiting) {
                    raiting=newRaiting;
                  }
              ),
              const Divider(color: Colors.black54, height: 2),
              const ListTile(
                leading: Icon(Icons.format_color_fill),
                title: Text('Tema:'),
              ),
              ThemeSwitcher(),
              const Divider(color: Colors.black54, height: 2),
              const ListTile(
                leading: Icon(Icons.color_lens_outlined),
                title: Text('Color:'),
              ),
              ColorSwitcher(),
            ],
          ),
        ),
      ),
    );
  }
}