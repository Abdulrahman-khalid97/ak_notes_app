

import 'package:ak_notes_app/features/auth/presentation/bodies/settings_page_body.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/account_details_page.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/language_page.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/setiting_page.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/update_password_page.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/verification_page.dart';
import 'package:ak_notes_app/features/notes/presentation/pages/add_note_page.dart';
import 'package:ak_notes_app/features/notes/presentation/pages/note_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/widget_tree_page.dart';


import 'package:flutter/material.dart';





class RouteManager{

  static const String homePage="/";
  static const String loginPage="/login";
  static const String registerPage="/register";
  static const String settingPage="/setting";
  static const String updatePasswordPage="/updatePassword";
  static const String changeLangPage="/changeLanguage";
  static const String widgetTreePage="/widgetTreeView";
  static const String addNotePage="/addNotePage";
  static const String verificationPage="/verificationView";
  static const String accountDetailsPage="/accountDetailsPage";

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case widgetTreePage :
        return MaterialPageRoute(builder: (context)=>const WidgetTree());
      case homePage :
        return MaterialPageRoute(builder: (context)=> const NotesPage());
      case addNotePage :
        return MaterialPageRoute(builder: (context)=> const AddNotePage());
      case loginPage :
        return MaterialPageRoute(builder: (context)=>const LoginPage());
      case registerPage :
        return MaterialPageRoute(builder: (context)=>const RegisterPage());
      case verificationPage :
        return MaterialPageRoute(builder: (context)=>const VerificationPage());
      case settingPage :
        return MaterialPageRoute(builder: (context)=>const SettingPage());
      case updatePasswordPage :
        return MaterialPageRoute(builder: (context)=>const UpdatePasswordPage());
      case changeLangPage :
        return MaterialPageRoute(builder: (context)=>const LanguagePage());
      case accountDetailsPage :
        return MaterialPageRoute(builder: (context)=>const AccountDetailsPage());
      default :
        throw const FormatException("Error in Route");




    }

  }

}