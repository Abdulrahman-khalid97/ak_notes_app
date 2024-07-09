import 'package:ak_notes_app/features/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';

import '../bodies/edit_note_body.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key, this.note});

  final Note? note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditNoteBody(note: note,),
    );
  }
}
