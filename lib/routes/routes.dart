

import 'package:ak_notes_app/views/add_note_view.dart';
import 'package:ak_notes_app/views/change_password_view.dart';
import 'package:ak_notes_app/views/language_view.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/register_view.dart';
import 'package:ak_notes_app/views/settings_view.dart';

import 'package:ak_notes_app/views/verfication_view.dart';
import 'package:flutter/material.dart';
import '../views/notes_view.dart';
import '../views/widget_tree.dart';


class RouteManager{

  static const String homeView="/";
  static const String loginView="/login";
  static const String registerView="/register";
  static const String settingView="/setting";
  static const String updatePasswordView="/updatePassword";
  static const String changeLangView="/changeLanguage";
  static const String widgetTreeView="/widgetTreeView";
  static const String addNoteView="/addNoteView";
  static const String verificationView="/verificationView";

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case widgetTreeView :
        return MaterialPageRoute(builder: (context)=>const WidgetTree());
      case homeView :
        return MaterialPageRoute(builder: (context)=> NoteView());
      case addNoteView :
        return MaterialPageRoute(builder: (context)=> const AddNoteView());
      case loginView :
        return MaterialPageRoute(builder: (context)=>const LoginView());
      case registerView :
        return MaterialPageRoute(builder: (context)=>const RegisterView());
      case verificationView :
        return MaterialPageRoute(builder: (context)=>const VerficationView());
      case settingView :
        return MaterialPageRoute(builder: (context)=>const SettingsView());
      case updatePasswordView :
        return MaterialPageRoute(builder: (context)=>const ChangePasswordView());
      case changeLangView :
        return MaterialPageRoute(builder: (context)=>const LanguageView());
      default :
        throw const FormatException("Error in Route");




    }

  }

}