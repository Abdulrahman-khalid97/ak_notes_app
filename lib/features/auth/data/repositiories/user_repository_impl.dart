
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception..dart';
import '../../../../core/network/network.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({required this.userRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, UserEntity>> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }


  @override
  Future<Either<Failure, Unit>> addUser(UserEntity user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateUserPassword(String uid , String password) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.updateUserPassword(uid, password);
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