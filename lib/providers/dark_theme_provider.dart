import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    log("isDarkMode: $value");
    notifyListeners();
  }
}
