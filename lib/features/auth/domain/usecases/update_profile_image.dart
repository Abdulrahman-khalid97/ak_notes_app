
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileImageUseCase{

  final AuthRepository repository;

  UpdateProfileImageUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(String profileUrl) async{
    return await repository.updateProfileImage(profileUrl);
  }


}