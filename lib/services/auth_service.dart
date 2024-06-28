import 'package:ak_notes_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/user_controller.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges=> _firebaseAuth.authStateChanges();
  Stream<UserModel> get user{
    return _firebaseAuth.authStateChanges().map((value)=> UserModel.fromMap(value as DocumentSnapshot<Map<String, dynamic>>));
  }


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
    required String fName ,
    required String lName ,
    required gender ,
    required age
  }) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim()).then((value){
            sendEmailVerificationEmail().then((value) async{
              await UserController().storeUser(UserModel(
                  fName: fName,
                  lName: lName,
                  gender: gender,
                  age: age,
                  userName: displayName,
                  email: email,
                  password: password
              ) ,);

            });
            value.user?.updateProfile(displayName: displayName);
      });
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
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Re-authenticate the user
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);
        // Update the password
        await user.updatePassword(newPassword);
        print('Password updated successfully');
      } catch (e) {
        print('Error updating password: $e');
      }
    } else {
      print('No user signed in');
    }
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }


}