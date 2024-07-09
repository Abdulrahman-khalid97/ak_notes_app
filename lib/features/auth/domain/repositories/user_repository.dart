


import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class UserRepository{
  // Declare all Operation on Feature
  Future<Either<Failure , UserEntity>> getUserInfo();
  Future<Either<Failure , Unit>> deleteUser();
  Future<Either<Failure , Unit>> updateUser(UserEntity user);
  Future<Either<Failure , Unit>> addUser(UserEntity user);

}