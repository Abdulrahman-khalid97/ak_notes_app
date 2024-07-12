
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ak_notes_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:ak_notes_app/features/auth/data/models/user_model.dart';
import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exception..dart';
import '../../../../core/network/network.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.userRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword(String email, String password) async{
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signInWithEmailAndPassword(email, password);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut()  async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signOut();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword(UserEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel=UserModel(displayName: user.displayName ,
        firstName: user.firstName , lastName: user.lastName , email:  user.email ,
        password: user.password,
        imageUrl: user.imageUrl , createdAt: user.createdAt , updatedAt: user.updatedAt
        );

        print(userModel.toJson());
        print("Before");
        await authRemoteDataSource.signUpWithEmailAndPassword(userModel);
        print("after");
        await userRemoteDataSource.addUser(userModel,FirebaseAuth.instance.currentUser!.uid);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }

  @override
  Stream<User?> getAuthStateChanges(){

        return authRemoteDataSource.getAuthStateChanges();

  }

  @override
 User? getCurrentUser() {

    return  authRemoteDataSource.getCurrentUser();
    // if (await networkInfo.isConnected) {
    //   try {
    //
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   throw Left(InternetConnectionFailure());
    // }
  }

  @override
  Future<Either<Failure, Unit>> sendEmailVerificationEmail()  async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.sendEmailVerification();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String oldPassword , String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.updatePassword(oldPassword, newPassword);
        await userRemoteDataSource.updateUserPassword(getCurrentUser()!.uid, newPassword);
        return Right(unit);
      } on ServerException catch(e){
        return Left(ServerFailure());
      }on WrongDataFailure catch(e){
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }





}