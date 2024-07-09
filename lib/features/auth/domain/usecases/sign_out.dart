
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignOutUseCase {

  final AuthRepository repository;

  SignOutUseCase({required this.repository});
  Future<Either<Failure , Unit>> call () async{

    return await repository.signOut();
  }
}