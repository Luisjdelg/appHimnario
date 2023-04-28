import 'dart:ui';
import 'package:apphimnario/pages/config/config-page.dart';
import 'package:apphimnario/pages/config/theme/app-colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/localStorage/storage-service.dart';
import '../../myprovider/theme-provider.dart';

class ConfigScreens extends StatelessWidget {
  final StorageService storageService;
  const ConfigScreens({Key? key, required this.storageService,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Rebuilt App!');
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storageService),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: ConfigPage(),
        builder: (c, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.selectedThemeMode,
            theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
                primaryColor: themeProvider.selectedPrimaryColor,
                appBarTheme: AppBarTheme(
                    color: themeProvider.selectedPrimaryColor, iconTheme: const IconThemeData(color: Colors.white)),
                listTileTheme: ListTileThemeData(
                    iconColor: themeProvider.selectedPrimaryColor),
                iconTheme: IconThemeData(color: themeProvider.selectedPrimaryColor),
                textTheme: TextTheme(bodyText1: themeProvider.letra)

            ),
            darkTheme: ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor).shade900,
                drawerTheme: DrawerThemeData(
                    backgroundColor: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor).shade900,
                    scrimColor: Colors.transparent),
                brightness: Brightness.dark,
                primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
                primaryColor: themeProvider.selectedPrimaryColor,
                iconTheme: IconThemeData(color: themeProvider.selectedPrimaryColor),
                textTheme: TextTheme(bodyText1: themeProvider.letra)
            ),
            home: child,
          );
        },
      ),
    );
  }
}

