
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeleteNoteUseCase{

  final NotesRepository repository;

  DeleteNoteUseCase({required this.repository});



  Future<Either<Failure , Unit>> call(String userId , String noteId) async{

    return await repository.deleteNote(userId, noteId);

  }
}