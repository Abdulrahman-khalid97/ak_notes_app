

import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailVerificationUseCase{

  final  AuthRepository repository;

  EmailVerificationUseCase({required this.repository});

  Future<Either<Failure , Unit>> call() async{
    return await repository.sendEmailVerificationEmail();
  }
}