
import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/notes/data/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/strings/db_string.dart';

abstract class NoteRemoteDataSource{
  Future<List<NoteModel>> getAllNote(String userId);
  Future<Unit> deleteNote(String userId , String noteId);
  Future<Unit> updateNote(String userId , NoteModel note);
  Future<Unit> addNote(String userId , NoteModel note);
  Stream<List<NoteModel>> streamNotes(String userId);
}

class NoteRemoteDataSourceWithFire implements NoteRemoteDataSource{
final FirebaseFirestore db;

  NoteRemoteDataSourceWithFire({required this.db});
  @override
  Future<List<NoteModel>> getAllNote(String userId) async {
    try{
      var ref = db.collection(USERS_COLLECTION).doc(userId).collection(NOTES_COLLECTION);
      final querySnapshot = await ref.get();
      return querySnapshot.docs.map((doc) => NoteModel.fromJson(doc.data()  , doc.id)).toList();
    } on ServerException{
      throw ServerFailure();
    } catch(e){
      print(e.toString());
      throw ServerException();
    }
  }


  @override
  Future<Unit> addNote(String userId, NoteModel note) async {

    try{
       final docRef = await db.collection(USERS_COLLECTION).doc(userId).collection(NOTES_COLLECTION).add(note.toJson());
      return Future.value(unit);
      }on ServerException{
      throw ServerFailure();
    }

  }

  @override
  Future<Unit> deleteNote(String userId, String noteId) async {
    try{
      await db.collection(USERS_COLLECTION).doc(userId).collection(NOTES_COLLECTION).doc(noteId).delete();
      return Future.value(unit);
    }on ServerException{
      throw ServerFailure();
    }
  }


  @override
  Future<Unit> updateNote(String userId, NoteModel note) async{

    try{
      await db.collection(USERS_COLLECTION).doc(userId).collection(NOTES_COLLECTION).doc(note.id).set(note.toJson());
      print(note.toJson());
      return Future.value(unit);
    }on ServerException{
      throw ServerFailure();
    }
  }
@override
Stream<List<NoteModel>> streamNotes(String uid){
  var ref = db.collection(USERS_COLLECTION).doc(uid).collection(NOTES_COLLECTION);
  return ref.snapshots().map((list)=>
      list.docs.map((doc)=>NoteModel.fromJson(doc.data() , doc.id)).toList());
}
}