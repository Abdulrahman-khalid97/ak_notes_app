

import 'dart:async';

import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_in_email_password.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_up_email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exception..dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/email_verification.dart';
import '../../domain/usecases/get_auth_state_changes.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/update_password.dart';
import '../../domain/usecases/update_profile_image.dart';


class AuthenticationProvider extends ChangeNotifier{

  final SignUpEmailPassword signUpEmailPassword;
  final SignInEmailPasswordUseCase signInEmailPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetAuthStateChangeUseCase getAuthStateChangeUseCase;
  final EmailVerificationUseCase sendEmailVerification;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  AuthenticationProvider(  {required this.updateProfileImageUseCase,required this.updatePasswordUseCase, required this.sendEmailVerification, required this.signUpEmailPassword, required this.signInEmailPasswordUseCase, required this.signOutUseCase, required this.getCurrentUserUseCase, required this.getAuthStateChangeUseCase});
   Stream<User?>? get authChanges=> getAuthStateChangeUseCase();
   User? get user => getCurrentUserUseCase();

  bool inProgressing= false;




  Future<void> login(String email , String password)async{
     try{
       inProgressing=true;
       notifyListeners();

       final loginOrFailure = await signInEmailPasswordUseCase(email, password);
       loginOrFailure.fold(
               (failure){
             throw _mapFailureToMessage(failure);
           }, (_){// Success never do any thing

       });

     }catch(exp){
       print(exp.toString());
      rethrow;
     }
     inProgressing=false;
     notifyListeners();

   }

  Future<void> register(UserEntity user)async{
    try{
      inProgressing=true;
      notifyListeners();
      final loginOrFailure = await signUpEmailPassword(user);
      loginOrFailure.fold(
              (failure){
            throw _mapFailureToMessage(failure);

          }, (_){


      });

    }catch(exp){
      rethrow;
    }
    inProgressing=false;
    notifyListeners();
  }



  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        throw ServerException();
      case EmptyCachedFailure:
        throw EmptyCacheException();
      case OffLineFailure:
        throw OffLineException();
      case InternetConnectionFailure:
        throw InternetConnectionException();
      default:
        throw Exception();
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


  Future<void> updatePassword(String old , String newPassword)async{
    try{
      print(old);
      print(newPassword);
      final updateOrFailure = await updatePasswordUseCase(old, newPassword);
      updateOrFailure.fold(
              (failure){
                print("failure");
            throw _mapFailureToMessage(failure);
          }, (_){// Success never do any thing
      });
    }catch(exp){
      print("Verification");
      rethrow;
    }

  }

  Future<void> updateProfileImage(String photoURL)async{
    try{

      final updateOrFailure = await updateProfileImageUseCase(photoURL);
      updateOrFailure.fold(
              (failure){

            throw _mapFailureToMessage(failure);
          }, (_){// Success never do any thing

      });
    }catch(exp){
      rethrow;
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    // super.dispose();
  }
}

