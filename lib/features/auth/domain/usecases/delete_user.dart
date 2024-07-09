

import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeleteUserUseCase{

  final UserRepository repository;

  DeleteUserUseCase({required this.repository});


  Future<Either<Failure , Unit>> call() async{

    return await repository.deleteUser();

  }
}