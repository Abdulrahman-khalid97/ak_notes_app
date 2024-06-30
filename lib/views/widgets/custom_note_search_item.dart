import 'package:flutter/material.dart';

import '../../models/note_model.dart';
import '../edit_note_view.dart';
class CustomNoteSearchItem extends StatelessWidget {
  const CustomNoteSearchItem({super.key, required this.note, this.deleteEvent});
  final NoteModel note;
  final void Function()? deleteEvent;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return  EditNoteView(note: note,);
            }),
          );
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.8),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notes_outlined,
                          color: Colors.blue,
                          size: 14,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(note.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));;
  }
}
