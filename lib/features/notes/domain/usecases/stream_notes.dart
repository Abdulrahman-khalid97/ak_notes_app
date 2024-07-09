
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';

import '../entities/note.dart';

class StreamNotes {

  final NotesRepository repository;

  StreamNotes({required this.repository});

  Stream<List<Note>> call(String userId){
    return repository.streamNotes(userId);
  }
}