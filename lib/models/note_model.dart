import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel{

   String? id;
   String title;
   String content;
   dynamic date;

  NoteModel( {
      required this.title,
      required this.content,
      required this.date,
  });

  Map<String , dynamic> toMap(){
    return{
       'title':title,
      'content': content ,
      'date':date

    };
  }

   NoteModel.fromMap(DocumentSnapshot<Map<String, dynamic>> doc)
     :id=doc.id,
     title=doc.data()!['title'] , content=doc.data()!['content'] ,
         date=doc.data()!['date'].toString();






}