
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/note.dart';

class UpdateNoteUseCase{

  final NotesRepository repository;

  UpdateNoteUseCase({required this.repository});



  Future<Either<Failure , Unit>> call(String userId , Note note) async{
    return await repository.updateNote(userId, note);

  }
}