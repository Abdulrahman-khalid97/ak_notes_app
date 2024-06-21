



import 'package:ak_notes_app/models/user_model.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class UserController{

  static Future<void> storeUser(FirebaseFirestore _firestore  , UserModel user ){
    print("User ${user.email}");
    return _firestore.collection(USERS_COLLECTION).doc().set({
      'userName' : user.userName,
      'email' : user.email,
      'password':user.password,

    });
  }
}