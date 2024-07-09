

import '../../domain/entities/user.dart';

class UserModel extends UserEntity{

  UserModel({super.id,
     super.imageUrl,
    super.displayName,
    super.firstName,
    super.lastName,
    super.email,
    super.password ,
    super.createdAt ,
    super.updatedAt
});




  factory UserModel.fromJson(Map<String , dynamic> json , String userId){
    return UserModel(
        id:userId,
        displayName: json["displayName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"] ,
      password: json["password"],
      imageUrl: json["imageUrl"],
      createdAt: json["createdAt"],
      updatedAt:  json["updatedAt"]
    );
  }

  factory UserModel.localFromJson(Map<String , dynamic> json){
    return UserModel(
        id:json["id"],
        displayName: json["displayName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"] ,
        password: json["password"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"],
        updatedAt:  json["updatedAt"]
    );
  }


  Map<String , dynamic> toJson(){

    return{
      "displayName":displayName ,
      "firstName":firstName ,
      "lastName":lastName,
      "email":email ,
      "password":password ,
      "imageUrl":imageUrl ,
      "createdAt":createdAt ,
      "updatedAt":updatedAt ,
    };
  }
}