

import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class AuthController extends ChangeNotifier{



  final _authService = AuthService();
  User? get currentUser => _authService.currentUser;
  Stream<User?> get authStateChanges=> _authService.authStateChanges;


  Future<void> signInWithEmailAndPassword({
    required String email ,
    required String password,
}) async{
    await _authService.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    print(password +email);

  }

  Future<void> createUserWithEmailAndPassword({
    required displayName ,
    required String email ,
    required String password,
    required String fName ,
    required String lName ,
    required gender ,
    required age
  }) async{
    try {
      print(email);
      return await _authService.createUserWithEmailAndPassword(displayName: displayName,
          email: email.trim(), password: password.trim(),
          fName: fName, lName: lName, gender: gender, age: age).then((value) async{
        _authService.sendEmailVerificationEmail().then((value){
          UserController().storeUser(
              UserModel(fName: fName,
                  lName: lName,
                  gender: gender,
                  age: age,
                  userName: displayName,
                  email: email,
                  password: password));
        }).then((value){
            print("AuthController : Have Verified");
        }).catchError((error){
          print("AuthController : Error during Verify");
        })
        ;});


    }
    catch(e){
      print("Error "+e.toString());
    }
    }
  Future<void> sendEmailVerificationEmail() async{
    try{
      await currentUser?.sendEmailVerification();
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> updatePassword(String currentPassword, String newPassword) async {

   return await _authService.updatePassword(currentPassword, newPassword);

  }

  Future<void> signOut() async{
    await _authService.signOut();
  }
}

