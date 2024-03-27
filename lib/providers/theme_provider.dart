import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  //toggleTheme
  ThemeMode _themeMode = ThemeMode.system;

  //toggle theme
  void toggleTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
