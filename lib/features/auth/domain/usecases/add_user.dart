

import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

class AddUserUseCase {
  final UserRepository repository;

  AddUserUseCase({required this.repository});
  Future<Either<Failure , Unit>> call(UserEntity user) async{

    return await repository.addUser(user);


  }
}