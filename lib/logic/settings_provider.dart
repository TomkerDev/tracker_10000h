import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // Par défaut, on peut rester sur le mode système ou forcer le sombre
  ThemeMode _themeMode = ThemeMode.dark; 

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}