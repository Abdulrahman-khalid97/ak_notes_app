

import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

class GetUserInfoUseCase{

  final UserRepository repository;

  GetUserInfoUseCase({required this.repository});

  Future<Either<Failure ,UserEntity>> call() async{
    return await repository.getUserInfo();
  }
}