
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/note.dart';

class GetAllNotesUseCase{

  final NotesRepository repository;

  GetAllNotesUseCase({required this.repository});


  Future<Either<Failure , List<Note>>> call(String userId) async{
    return await repository.getAllNotes(userId);
  }
}