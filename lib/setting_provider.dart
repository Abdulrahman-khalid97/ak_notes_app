

import 'package:ak_notes_app/shared_pref.dart';
import 'package:flutter/foundation.dart';

class SettingProvider extends ChangeNotifier{


  String? local;
  bool? isDarkMode;

  SettingProvider(){
    local=  SharedPref.lang!;
    isDarkMode = SharedPref.initialIsDarkMode;
    notifyListeners();
  }
  getSetting(){

  }
  updateLocal(String? lang){
    local=lang;
    SharedPref.addLang(lang!);
    notifyListeners();
  }

  toggleTheme(bool? isDark){
    isDarkMode=isDark;
    SharedPref.toggleTheme(isDark!);
    notifyListeners();
  }

}