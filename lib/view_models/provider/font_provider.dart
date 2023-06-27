


import 'package:flutter/material.dart';
import 'package:montion_verse/ui/views/settings_screen/shared_data.dart';

class FontControlProvider extends ChangeNotifier{
  double _fontSize = 15;
  late FontPreferences fontPreferences;
  double get currFontSize => _fontSize;

  FontControlProvider() {
    _fontSize = 15;
    fontPreferences = FontPreferences();
    getFontPreferences();
  }

  set fontSize(double value) {
    _fontSize = value;
    FontPreferences.saveFontSize(value);
    notifyListeners();
  }
  getFontPreferences() async {
    _fontSize = await FontPreferences.getFontSize();
    notifyListeners();
  }

}