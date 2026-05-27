import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Por defecto usamos el modo del sistema
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Método para alternar manualmente (el que usará tu botón provisional)
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  // Método para establecer un tema específico
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}