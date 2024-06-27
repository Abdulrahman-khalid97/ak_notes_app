

import 'dart:async';

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/services/database_service.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

  class  NotesController extends ChangeNotifier{

    List<NoteModel>? notes=[];

    StreamSubscription<List<NoteModel>>? _subscription;
    Stream<List<NoteModel>>? data;


    Stream<List<NoteModel>> streamNotes(String uid) {
       data =  DatabaseService().streamNotes(uid);
       _subscription = data?.listen((List<NoteModel> newNotes) {
         notes = newNotes;
         notifyListeners();
       });

       return data!;
    }

    Future<void> add( {NoteModel? note , UserModel? user}){
      return DatabaseService().storeNote(note!);

    }

    Future<void> update(NoteModel note ){
      return  DatabaseService().updateNote(note);
    }
    Future<void> delete(NoteModel note) async{

      final delete= await DatabaseService().deleteNote(note);
      notifyListeners();
      return delete;

    }

    static Stream<List<NoteModel>> fetchData(FirebaseFirestore _firestore){
    return _firestore
        .collection(USERS_COLLECTION)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .asyncExpand((querySnapshot) async* {
        final noteCollection = querySnapshot.reference.collection(NOTES_COLLECTION);
        yield* noteCollection.snapshots().map((noteQuerySnapshot) {
          return noteQuerySnapshot.docs.map((noteDoc) {
            return NoteModel.fromMap(noteDoc);
          }).toList();
        });

    });



  }




}