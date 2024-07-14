

import 'package:ak_notes_app/features/auth/domain/usecases/add_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/delete_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/update_user.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exception..dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/update_user_password.dart';

class UserCrudProvider extends ChangeNotifier{
  final AddUserUseCase addUserUseCase ;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserPasswordUseCase updateUserPasswordUseCase;

  UserCrudProvider( {required this.updateUserPasswordUseCase,required this.addUserUseCase, required this.updateUserUseCase, required this.deleteUserUseCase, required this.getUserInfoUseCase});

  Future<void> updatePassword(String uid , String newPassword)async{
    try{
      print(newPassword);
      final updateOrFailure = await updateUserPasswordUseCase(uid , newPassword);
      updateOrFailure.fold(
              (failure){
            print("failure");
            throw _mapFailureToMessage(failure);
          }, (_){// Success never do any thing
      });
    }catch(exp){
      print("Verification");
      rethrow;
    }

  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        throw ServerException();
      case EmptyCachedFailure:
        throw EmptyCacheException();
      case OffLineFailure:
        throw OffLineException();
      case InternetConnectionFailure:
        throw InternetConnectionException();
      default:
        throw Exception();
    }
  }
}