
/*
import 'package:apphimnario/model/event-model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ShopDatabase{
  static final ShopDatabase instance = ShopDatabase._init();
  //static Database? _database;
  ShopDatabase._init();
  final String tableCartItems = 'cart_items';
  //
  /*
Future<Database> get database async{
  if(_database != null) return _database!;
  print("Creando db");

  _database = await _initDB('shop.db');
  return _database!;
}
*/
Future<Database> _initDB(String filePath) async {
  final dbPath = await  getDatabasesPath();
  final path = join(dbPath, filePath);
  final directory = await getApplicationDocumentsDirectory();
  print('ruta de base de datos: $dbPath'); // imprime la ruta de la base de datos
  return await openDatabase(path, version: 1,onCreate: _onCreateDB);
}
Future _onCreateDB(Database db, int version) async {
  await db.execute('''
   CREATE TABLE  cart_items(
   idEvent INTEGER PRIMARY KEY,
   nameEvent TEXT)
   ''');
}
// insertar datos a la base de datos


  Future<String> getDatabasePath(String dbName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    return path;
  }
}
*/
