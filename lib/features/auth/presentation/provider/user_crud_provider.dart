

import 'package:ak_notes_app/features/auth/domain/usecases/add_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/delete_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/update_user.dart';
import 'package:flutter/foundation.dart';

class UserCrudProvider extends ChangeNotifier{
  final AddUserUseCase addUserUseCase ;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;

  UserCrudProvider({required this.addUserUseCase, required this.updateUserUseCase, required this.deleteUserUseCase, required this.getUserInfoUseCase});
}