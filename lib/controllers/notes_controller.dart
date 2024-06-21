

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final class  NotesController{


  static Future<void> storeNote(FirebaseFirestore _firestore, NoteModel note ){
   return _firestore.collection(USERS_COLLECTION).where("email" , isEqualTo: AuthController().currentUser?.email).limit(1).get().then((snapshots){

     snapshots.docs.first.reference.collection(NOTES_COLLECTION).add(note.toMap());
   }).catchError((onError){
     print("on error");
   });
  }



  static Stream<List<NoteModel>> fetchData(FirebaseFirestore _firestore){
    return _firestore
        .collection(USERS_COLLECTION)
        .where("email", isEqualTo: AuthController().currentUser?.email)
        .limit(1)
        .snapshots()
        .asyncExpand((querySnapshot) async* {
      for (final doc in querySnapshot.docs) {
        final noteCollection = doc.reference.collection(NOTES_COLLECTION);
        yield* noteCollection.snapshots().map((noteQuerySnapshot) {
          return noteQuerySnapshot.docs.map((noteDoc) {
            return NoteModel.fromMap(noteDoc);
          }).toList();
        });
      }
    });



  }



  static deleteNote(FirebaseFirestore _firestore ,NoteModel note)async{
   // await _firestore.collection(USERS_COLLECTION).doc(note.id).delete();
    final userDoc = await _firestore
        .collection(USERS_COLLECTION)
        .where("email", isEqualTo: AuthController().currentUser?.email)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    await userDoc.reference
        .collection(NOTES_COLLECTION)
        .doc(note.id)
        .delete();
  }

  static Future<void> updateNote(FirebaseFirestore _firestore , NoteModel note) async{
   // return await _firestore.collection(collectionName).doc(note.id).update(note.toMap());
    final userDoc = await _firestore
        .collection(USERS_COLLECTION)
        .where("email", isEqualTo: AuthController().currentUser?.email)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    await userDoc.reference
        .collection(NOTES_COLLECTION)
        .doc(note.id)
        .update({
      'title': note.title,
      'content': note.content,
      'date': note.date,
    });
  }
}