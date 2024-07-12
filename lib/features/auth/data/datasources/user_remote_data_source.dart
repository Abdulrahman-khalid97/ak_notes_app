

import 'package:ak_notes_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception..dart';
import '../../../../core/error/failure.dart';
import '../../../../core/strings/db_string.dart';
import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource{
  Future<UserEntity> getUserInfo();
  Future<Unit> deleteUser();
  Future<Unit> updateUser(UserEntity user);
  Future<Unit> addUser(UserModel user , String id);
  Future<Unit> updateUserPassword( String id , String password);
}
class UserRemoteDataSourceFB implements UserRemoteDataSource{
  final FirebaseFirestore db;

  UserRemoteDataSourceFB({required this.db});
  @override
  Future<Unit> addUser(UserModel user , String id) async {
    try{
      await db.collection(USERS_COLLECTION).doc(id).set(user.toJson());
      return Future.value(unit);
    } on ServerException{
      throw  ServerFailure();
    }
  }

  @override
  Future<Unit> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateUserPassword(String id , String password) async {
    try{
      await db.collection(USERS_COLLECTION).doc(id).update({"password":password});
      return Future.value(unit);
    } on ServerException{
      throw  ServerFailure();
    }
  }


}