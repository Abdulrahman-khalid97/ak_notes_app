
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable{
   String? id;
 final String? title;
 final String? content;
 final Timestamp? createdAt;
 final Timestamp? updateAt;


   Note({this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updateAt});

  @override
  // TODO: implement props
  List<Object?> get props => [id , title , content , createdAt , updateAt];


}