

import 'package:firebase_auth/firebase_auth.dart';

class AuthController{


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges=> _firebaseAuth.authStateChanges();


  Future<void> signInWithEmailAndPassword({
    required String email ,
    required String password,
}) async{
    print(password +email);
  await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  Future<void> createUserWithEmailAndPassword({
    required displayName ,
    required String email ,
    required String password,
  }) async{
    try {
      print(email);
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim()).then((value){
            value.user?.updateProfile(displayName: displayName);
      });


    }
    catch(e){
      print("Error "+e.toString());
    }
    }
  Future<void> sendEmailVerficationEmail() async{
    try{
      await currentUser?.sendEmailVerification();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();

  }
}

