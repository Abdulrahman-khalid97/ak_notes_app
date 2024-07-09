

import 'dart:async';

import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_in_email_password.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_up_email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../app_local.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_auth_state_changes.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_out.dart';


class AuthenticationProvider extends ChangeNotifier{
  final SignUpEmailPassword signUpEmailPassword;
  final SignInEmailPasswordUseCase signInEmailPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetAuthStateChangeUseCase getAuthStateChangeUseCase;
String _message="";

  AuthenticationProvider({required this.signUpEmailPassword, required this.signInEmailPasswordUseCase, required this.signOutUseCase, required this.getCurrentUserUseCase, required this.getAuthStateChangeUseCase});

   Stream<User?>? get authChanges=> getAuthStateChangeUseCase();
   User? get user => getCurrentUserUseCase();

   Future<void> login(String email , String password)async{
     try{
       final loginOrFailure = await signInEmailPasswordUseCase(email, password);
       loginOrFailure.fold(
               (failure){
             _message= _mapFailureToMessage(failure);
             notifyListeners();
           }, (_){
         _message=AppLocal.loc.logIn;
         notifyListeners();
       });
     }catch(exp){
       print("Login : $exp");
     }

   }

  Future<void> register(UserEntity user)async{
    try{
      final loginOrFailure = await signUpEmailPassword(user);
      loginOrFailure.fold(
              (failure){
            _message= _mapFailureToMessage(failure);
            notifyListeners();
          }, (_){
        _message=AppLocal.loc.logIn;
        notifyListeners();
      });
    }catch(exp){
      print("Register : $exp");
    }

  }


  String _mapFailureToMessage(Failure failure){

    switch(failure.runtimeType){
      case ServerFailure:
        return "Server Failure";
      case EmptyCachedFailure:
        return "Empty Cached";
      case InternetConnectionFailure:
        return "InternetConnectionFailure";
      default:
        return "UnExpected Error , Please try later";
    }
  }

  Future<void> signOut() async{

    try{
      final loginOrFailure = await signOutUseCase();
      loginOrFailure.fold(
              (failure){
            throw _mapFailureToMessage(failure);

          }, (_){

      });
    }catch(exp){
     rethrow;
    }

  }
}