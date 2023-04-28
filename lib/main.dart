import 'dart:async';
import 'package:apphimnario/data/localStorage/service-locator.dart';
import 'package:apphimnario/data/localStorage/storage-service.dart';
import 'package:apphimnario/myprovider/theme-provider.dart';
import 'package:apphimnario/pages/config/theme/app-colors.dart';
import 'package:apphimnario/pages/home/home-pege.dart';
import 'package:apphimnario/myprovider/myprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<Future<void>>(() async {
    setUpServiceLocator();
    final StorageService storageService = getIt<StorageService>();
    await storageService.init();
   // await SqfliteDatabaseHelper.instance.db;
    runApp(MyApp(
      storageService: storageService,
    ));
  }, (e, _) => throw e);
}
class MyApp extends StatelessWidget {
  final StorageService storageService;
  const MyApp({Key? key, required this.storageService,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => MyProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: HomePage(),
        builder: (context, themeProvider, home) {
          return MaterialApp(
            title: 'Himnario',
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
              //textTheme: TextTheme(bodyText1: themeProvider.letra)
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor).shade900,
              drawerTheme: DrawerThemeData(backgroundColor: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor).shade900),
              brightness: Brightness.dark,
              primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
              primaryColor: themeProvider.selectedPrimaryColor,
              iconTheme: IconThemeData(color: themeProvider.selectedPrimaryColor),
              //textTheme: TextTheme(bodyText1: themeProvider.letra)
            ),
            home: home,
          );
        },
      ),
    );
  }

}

