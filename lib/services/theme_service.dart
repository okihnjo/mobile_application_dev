import 'package:flutter/material.dart';

class ChangeThemeState extends ChangeNotifier {
  bool darkMode = false;

  void enableDarkMode() {
    darkMode = true;
    notifyListeners();
  }

  void enableLightMode() {
    darkMode = false;
    notifyListeners();
  }
}
