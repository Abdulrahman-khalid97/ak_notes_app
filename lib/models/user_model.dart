

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{


   String? id;
   String? fName ;
   String? lName;
   String? gender;
   String? age;
   String? userName;
   String? email;
    String? password;

   UserModel.empty();
   UserModel({
     this.id,
     required this.fName,
     required this.lName,
     required this.gender,
     required this.age,
     required this.userName,
     required this.email,
     required this.password});

   Map<String , dynamic> toMap(){
     return {
       "id":id ,
       "firstName":fName ,
       "lastName":lName,
       "gender":gender ,
       "age": age,
       "userName":userName,
       "email":email,
       "password":password
     };
   }

   UserModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc):
         id=doc.id,
   fName = doc.data()!["firstName"] ,
   lName= doc.data()!["lastName"] ,
   gender =  doc.data()!["gender"] ,
   age =  doc.data()!["age"] ,
       userName=doc.data()!['userName'] ,
         email=doc.data()!['email'] ,
         password=doc.data()!['password'];


   factory UserModel.frmMap(Map data, String s){
     return UserModel(
       id:s,
         fName: data['firstName'],
         lName: data['lastName'],
         gender: data ['gender'],
         age: data ['age'],
         userName: data ['userName'],
         email: data ['email'],
         password: data ['password']);
   }

}