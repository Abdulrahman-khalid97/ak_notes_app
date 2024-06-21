



import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/models/user_model.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/note_model.dart';
import 'auth_controller.dart';

class FirebaseController extends ChangeNotifier{

  final String NOTES = "notes";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   List<NoteModel>? notes=[];


  Stream<List<NoteModel>> fetchNotes(){
     return  NotesController.fetchData(_firestore).map((snap){
       return notes= snap;
     });

  }

  Future<void> add( {NoteModel? note , UserModel? user}){

      return NotesController.storeNote(_firestore, note!);

  }

  delete(String collectionName , NoteModel note)async{

    NotesController.deleteNote(_firestore ,note);
  }

  Future<void> update(String collectionName , NoteModel note ){
    return  NotesController.updateNote(_firestore  , note);
  }


  Future<void> createUserWithEmailAndPassword(String userName , String email , String password)async{
    try{
      await AuthController().createUserWithEmailAndPassword(displayName: userName, email: email, password: password).then((value) async{
        await UserController.storeUser(_firestore,UserModel(userName: userName, email: email, password: password));
      }).catchError((onError){
        print(onError.toString());
      });
    } on FirebaseAuthException catch(e){
      print("CreateUser : "+e.message.toString());
    }
    notifyListeners();
  }
  Future<void> sendEmailVerficationEmail() async{
    try{
     AuthController().sendEmailVerficationEmail();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email , String password)async{
    try{
      await AuthController().signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){

      print("SignIn : "+e.message.toString());
    }
    notifyListeners();
  }
  Future<void> signOut() async{
    await AuthController().signOut();
  }
  Stream<User?> get authStateChanges=> AuthController().authStateChanges;


}