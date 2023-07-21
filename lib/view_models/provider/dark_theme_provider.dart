import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:montion_verse/shared_data/dark_theme.dart';


class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.system;


  bool _isDark = true;
  late ThemePreferences _preferences;
  bool get isDarkMode => _isDark;

  ThemeProvider() {
    _isDark = true;
    _preferences = ThemePreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}