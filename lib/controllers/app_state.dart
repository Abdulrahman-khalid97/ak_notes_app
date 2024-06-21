import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';

class AppState extends ChangeNotifier{
  Brightness? themeMode= Brightness.dark;
  bool initialIsDarkMode=true;
  AppState(){
    getState();
    themeMode = initialIsDarkMode! ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
  AppState.intial(bool initialIsDarkMode)
      : themeMode = initialIsDarkMode ? Brightness.dark : Brightness.light;

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? Brightness.dark : Brightness.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initialIsDarkMode = isOn;
    themeMode = initialIsDarkMode! ? Brightness.dark : Brightness.light;
    await prefs.setBool('isDarkMode', isOn);
    notifyListeners();
  }


  getState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

     initialIsDarkMode = prefs.getBool('isDarkMode')?? true;
    themeMode = initialIsDarkMode! ? Brightness.dark : Brightness.light;
    notifyListeners();

  }
}