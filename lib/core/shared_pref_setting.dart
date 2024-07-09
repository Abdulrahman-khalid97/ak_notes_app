
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static String? lang;
  static bool? initialIsDarkMode;
  static addLang(String lang) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("lang", lang);
  }

  static Future<String> getLang() async{

    SharedPreferences sp = await SharedPreferences.getInstance();
    lang = sp.getString("lang") ?? 'en';
    return lang!;
  }

  static  Future<bool> getState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initialIsDarkMode =  prefs.getBool('isDarkMode')??true;
    return initialIsDarkMode!;
  }

  static Future<void> toggleTheme(bool isOn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initialIsDarkMode = isOn;
    await prefs.setBool('isDarkMode', isOn);
  }
}