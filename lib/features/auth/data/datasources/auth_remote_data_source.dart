import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signInWithEmailAndPassword(String email, String password);

  Future<Unit> signUpWithEmailAndPassword(UserModel user);
  Future<void> sendEmailVerification();
  Future<Unit> updatePassword(String currentPassword, String newPassword);
  Future<Unit> updateProfileImage(String profileUrl);
  Future<Unit> signOut();
  Stream<User?> getAuthStateChanges();
  User? getCurrentUser();

}

class AuthRemoteDataSourceFB implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceFB({required this.firebaseAuth});

  @override
  Future<Unit> signInWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<Unit> signOut()async {
    try {
      await firebaseAuth.signOut();
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<Unit> signUpWithEmailAndPassword(UserModel user) async {

    try {

      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!.trim(), password: user.password!.trim())
          .then((value) {
        value.user?.updateProfile(
            displayName: user.displayName, photoURL: user.imageUrl);
      });
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }


  @override
  Stream<User?> getAuthStateChanges(){
    return firebaseAuth.authStateChanges();
  }

  @override
  User? getCurrentUser() {
   return firebaseAuth.currentUser;
  }

  @override
  Future<void> sendEmailVerification() async {
    try {

      await firebaseAuth.currentUser!.sendEmailVerification();
      return Future.value(unit);
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<Unit> updatePassword(String currentPassword, String newPassword) async {
    final user = getCurrentUser();

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
        return Future.value(unit);
      } catch (e) {
        print('Error updating password: $e');
        throw ServerFailure();
      }
    } else {
      print('No user signed in');
      throw WrongDataFailure();
    }
  }

  @override
  Future<Unit> updateProfileImage(String profileUrl) async {
    final user = getCurrentUser();
    if (user != null) {
      try {

        await user.updatePhotoURL(profileUrl);
        return Future.value(unit);
      } catch (e) {
        print('Error updating profileImage: $e');
        throw ServerFailure();
      }
    } else {
      print('No user signed in');
      throw WrongDataFailure();
    }
  }

}
