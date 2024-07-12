

import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdatePasswordUseCase {

  final AuthRepository repository;

  UpdatePasswordUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String oldPassword , String newPassword) async {
    return await repository.updatePassword(oldPassword , newPassword);
  }
}