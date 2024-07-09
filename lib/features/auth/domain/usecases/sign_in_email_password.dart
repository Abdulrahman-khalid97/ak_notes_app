

import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignInEmailPasswordUseCase{

  final AuthRepository repository;

  SignInEmailPasswordUseCase({required this.repository});
  Future<Either<Failure , Unit>> call (String email , String password) async{

    return await repository.signInWithEmailAndPassword(email, password);
  }

}