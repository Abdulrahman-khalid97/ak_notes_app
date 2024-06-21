

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimtionController extends ChangeNotifier{

  bool animate=false;
  Future startAnimation ()  async{
    await Future.delayed(Duration(milliseconds: 500));
    animate=true;
    ChangeNotifier();
    await Future.delayed(Duration(milliseconds: 5000));
    ChangeNotifier();
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>WelcomeScreen()));
  }
}