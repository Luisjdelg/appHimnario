
import 'package:apphimnario/data/localStorage/storage-service.dart';
import 'package:get_it/get_it.dart';
import 'hive_storage_service.dart';

final getIt = GetIt.I;
void setUpServiceLocator() {
  getIt.registerSingleton<StorageService>(HiveStorageService());
}
