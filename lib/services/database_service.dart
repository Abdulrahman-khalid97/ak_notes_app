
import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class DatabaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> storeUser(UserModel user ){

    return _db.collection(USERS_COLLECTION).doc(AuthController().currentUser?.uid).set({
      'firstName':user.fName ,
      'lastName':user.lName,
      'gender':user.gender,
      'age':user.age,
      'userName' : user.userName,
      'email' : user.email,
      'password':user.password,
      'createdAt': Timestamp.now(),
    });

  }

  Future<UserModel> getUser(String id) async{
    var snap = await _db.collection(USERS_COLLECTION).doc(id).get();
    return UserModel.fromMap(snap);
  }

  Stream<UserModel> streamUser(String id){
    return _db.collection(USERS_COLLECTION).doc(id).snapshots().map((snap) => UserModel.frmMap(snap.data()! , snap.id));
  }

  Future<void> updateUser(UserModel user) async {
    return await _db.collection(USERS_COLLECTION).doc(user.id).update(
        user.toMap());
  }


  Stream<List<NoteModel>> streamNotes(String uid){
    var ref = _db.collection(USERS_COLLECTION).doc(uid).collection(NOTES_COLLECTION);
    return ref.snapshots().map((list)=>
        list.docs.map((doc)=>NoteModel.fromFirestore(doc)).toList());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sn(String uid){
    var ref = _db.collection(USERS_COLLECTION).doc(uid).collection(NOTES_COLLECTION);
    return ref.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> snap(String uid){
    var ref = _db.collection(USERS_COLLECTION).doc(uid).collection(NOTES_COLLECTION);
    return ref.snapshots();
  }
   Future<void> storeNote(NoteModel note ){
    return _db.collection(USERS_COLLECTION).doc(AuthController().currentUser!.uid).get().then((snapshots){

      snapshots.reference.collection(NOTES_COLLECTION).add(note.toMap());
    }).catchError((onError){
      print("StoreNote : "+onError.toString());
    });

  }

   Future<void> updateNote(NoteModel note) async{
    // return await _firestore.collection(collectionName).doc(note.id).update(note.toMap());
    final userDoc = await _db.collection(USERS_COLLECTION)
        .doc(AuthController().currentUser?.uid)
        .get()
        .then((querySnapshot) => querySnapshot);

    await userDoc.reference
        .collection(NOTES_COLLECTION)
        .doc(note.id)
        .update({
      'title': note.title,
      'content': note.content,
      'date': note.date,
    });
  }

   Future<void> deleteNote(NoteModel note)async{
    // await _firestore.collection(USERS_COLLECTION).doc(note.id).delete();
    final userDoc = await _db
        .collection(USERS_COLLECTION)
        .doc(AuthController().currentUser?.uid)
        .get()
        .then((querySnapshot) => querySnapshot);
    return await userDoc.reference
        .collection(NOTES_COLLECTION)
        .doc(note.id)
        .delete();


  }


}