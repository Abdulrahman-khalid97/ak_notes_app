
import 'package:ak_notes_app/features/notes/domain/entities/note.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class NotesRepository{

  // Declare all Operation on Feature
  Future<Either<Failure , List<Note>>> getAllNotes(String userId);
  Future<Either<Failure , Unit>> deleteNote(String userID , String noteId);
  Future<Either<Failure , Unit>> updateNote(String userId , Note note);
  Future<Either<Failure , Unit>> addNote(String userId ,Note note);
  Stream<List<Note>> streamNotes(String userId);

}