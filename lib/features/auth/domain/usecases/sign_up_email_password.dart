

import 'package:ak_notes_app/features/auth/domain/entities/user.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignUpEmailPassword{
  final AuthRepository repository;

  SignUpEmailPassword({required this.repository});
  Future<Either<Failure , Unit>> call (UserEntity user) async{

    return await repository.signUpWithEmailAndPassword(user);
  }

}