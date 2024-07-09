

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  String? id;
   String? displayName;
   String? firstName;
   String? lastName;
   String? email;
   String? password;
   String? imageUrl;
   Timestamp? createdAt;
   Timestamp? updatedAt;

  UserEntity.empty();

  UserEntity({this.id,
    required this.imageUrl,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.createdAt ,
    required this.updatedAt
  });

  @override
  // TODO: implement props
  List<Object?> get props =>[id,firstName , lastName , displayName , email ,password , imageUrl , createdAt , updatedAt];



}