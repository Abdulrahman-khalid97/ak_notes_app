import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> signInWithEmailAndPassword(String email, String password);

  Future<Unit> signUpWithEmailAndPassword(UserModel user);

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
}
