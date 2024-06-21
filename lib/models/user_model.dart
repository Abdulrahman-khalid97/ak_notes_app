

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{


   String? id;
   String? userName;
   String? email;
   final String? password;

   UserModel({
     required this.userName,
     required this.email,
     required this.password});

   Map<String , dynamic> toMap(){
     return {
       "id":this.id ,
       "userName":this.userName,
       "email":this.email,
       "password":this.password
     };
   }

   UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc):
         id=doc.id,
         userName=doc.data()!['userName'] ,
         email=doc.data()!['email'] ,
         password=doc.data()!['password'];

}