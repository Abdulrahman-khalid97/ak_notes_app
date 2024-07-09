
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';

class GetAuthStateChangeUseCase{

  final AuthRepository repository;

  GetAuthStateChangeUseCase({required this.repository});

 Stream<User?> call() {

    return  repository.getAuthStateChanges();
  }
}