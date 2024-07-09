

import 'package:ak_notes_app/features/notes/domain/entities/note.dart';

class NoteModel extends Note{
  NoteModel( {super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    required super.updateAt});

  factory NoteModel.fromJson(Map<String , dynamic> json , String noteId){
    return NoteModel(
       id:noteId,
        title: json["title"],
        content: json["content"],
        createdAt: json["createdAt"],
        updateAt: json["updatedAt"]);
  }

  factory NoteModel.localFromJson(Map<String , dynamic> json){
    return NoteModel(
     id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: json["createdAt"],
        updateAt: json["updatedAt"]);
  }

  Map<String , dynamic> toJson(){

    return{
      "title":title ,
      "content":content ,
      "createdAt":createdAt,
      "updatedAt":updateAt
    };
  }
}