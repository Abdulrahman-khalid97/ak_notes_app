
import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdateUserPasswordUseCase{
  final UserRepository repository;

  UpdateUserPasswordUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(String uid , String password) async {
    return await repository.updateUserPassword(uid , password);
  }
  
}