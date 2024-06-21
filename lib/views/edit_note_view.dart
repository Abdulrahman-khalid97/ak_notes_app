import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/views/widgtes/edit_note_view_body.dart';
import 'package:flutter/material.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key, this.note});

 final NoteModel? note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditNoteViewBody(note: note,),
    );
  }
}
