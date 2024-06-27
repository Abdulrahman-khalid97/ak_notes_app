//
//
//
//
// import 'dart:async';
//
// import 'package:ak_notes_app/controllers/notes_controller.dart';
// import 'package:ak_notes_app/controllers/user_controller.dart';
// import 'package:ak_notes_app/models/user_model.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
//
// import '../models/note_model.dart';
//
// import 'auth_controller.dart';
//
// class FirebaseController extends ChangeNotifier{
//
//    FirebaseFirestore _firestore = FirebaseFirestore.instance;
//    List<NoteModel>? notes=[];
//    UserModel userModel = UserModel.empty();
//    Stream<List<NoteModel>>? data;
//    StreamSubscription<List<NoteModel>>? _subscription;
//
//   Stream<List<NoteModel>> fetchNotes(){
//     data=  NotesController.fetchData(_firestore);
//     _subscription = data?.listen((List<NoteModel> newNotes) {
//         notes = newNotes;
//     });
//     notifyListeners();
//     return data!;
//
//
//
//   }
//
//   // Future<void> add( {NoteModel? note , UserModel? user}){
//   //     return NotesController.storeNote(_firestore, note!);
//   //
//   // }
//
//
//   // Future<void> update(String collectionName , NoteModel note ){
//   //   return  NotesController.updateNote(_firestore  , note);
//   // }
//
//
//   // Future<void> createUserWithEmailAndPassword(String fName , String lName , String gender , int age ,  String userName , String email , String password)async{
//   //   try{
//   //     await AuthController().createUserWithEmailAndPassword(displayName: userName, email: email, password: password).then((value) async{
//   //       await UserController.storeUser(_firestore,UserModel(
//   //         fName: fName,
//   //           lName: lName,
//   //           gender: gender,
//   //           age: age,
//   //           userName: userName,
//   //           email: email,
//   //           password: password
//   //       ) ,);
//   //     }).catchError((onError){
//   //       print(onError.toString());
//   //     });
//   //   } on FirebaseAuthException catch(e){
//   //     print("CreateUser : "+e.message.toString());
//   //   }
//   //   notifyListeners();
//   // }
//   Future<void> sendEmailVerficationEmail() async{
//     try{
//      AuthController().sendEmailVerificationEmail();
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//   Future<void> signInWithEmailAndPassword(String email , String password)async{
//     try{
//       await AuthController().signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch(e){
//
//       print("SignIn : "+e.message.toString());
//     }
//     notifyListeners();
//   }
//   Future<void> signOut() async{
//     await AuthController().signOut();
//   }
//
//   // Future<void> fetchUserData(String userId) async {
//   //    await UserController().fetchUserData(userId).then((user){
//   //     // userModel=user;
//   //
//   //    });
//   //
//   // }
//
//   Future<void> updatePassword(String currentPassword , String newPassword ) async{
//      await AuthController().updatePassword(currentPassword, newPassword);
//   }
//    Future<void> updateUser(UserModel user) async{
//     // return await _firestore.collection(collectionName).doc(note.id).update(note.toMap());
//      userModel.fName= user.fName;
//      userModel.lName=user.lName;
//      userModel.gender=user.gender;
//      userModel.age=user.age;
//      print(user.lName);
//    return await UserController().updateUser(userModel);
//   }
//
//
//   Stream<User?> get authStateChanges=> AuthController().authStateChanges;
//
//
// }