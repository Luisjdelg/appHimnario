import 'package:apphimnario/pages/config/theme/app-colors.dart';
import 'package:flutter/material.dart';
import '../data/localStorage/storage-service.dart';

class ThemeProvider with ChangeNotifier {
  final StorageService storageService;
  ThemeProvider(this.storageService) {
    selectedPrimaryColor = storageService.get(StorageKeys.primaryColor) == null
        ? AppColors.primary
        : Color(storageService.get(StorageKeys.primaryColor));

    selectedThemeMode = storageService.get(StorageKeys.themeMode) == null
        ? ThemeMode.system
        : ThemeMode.values.byName(storageService.get(StorageKeys.themeMode));
  }

  late Color selectedPrimaryColor;

  setSelectedPrimaryColor(Color _color) {
    selectedPrimaryColor = _color;
    storageService.set(StorageKeys.primaryColor, _color.value);
    notifyListeners();
  }
  late TextStyle letra;

  setTextStyle(TextStyle _letra) {
    letra = _letra;
    storageService.set(StorageKeys.themeMode, _letra.fontSize);
    notifyListeners();
  }
  late ThemeMode selectedThemeMode;

  setSelectedThemeMode(ThemeMode _mode) {
    selectedThemeMode = _mode;
    storageService.set(StorageKeys.themeMode, _mode.name);
    notifyListeners();
  }
}
