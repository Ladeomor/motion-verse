import 'package:shared_preferences/shared_preferences.dart';

class FontPreferences{
  static Future<void> saveFontSize(double fontSize) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', fontSize);
  }
  static Future<double> getFontSize() async{
    final prefs = await SharedPreferences.getInstance();
    double? fontSize = prefs.getDouble('font_size');
    return fontSize ?? 15;
  }
}