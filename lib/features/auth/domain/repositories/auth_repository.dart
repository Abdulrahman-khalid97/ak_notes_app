

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository{

  // Declare all Operation on Feature
  Future<Either<Failure , Unit>> signInWithEmailAndPassword(String email , String password);
  Future<Either<Failure , Unit>> signUpWithEmailAndPassword(UserEntity user);
  Future<Either<Failure , Unit>> signOut();
 User? getCurrentUser();
 Stream<User?> getAuthStateChanges();

}