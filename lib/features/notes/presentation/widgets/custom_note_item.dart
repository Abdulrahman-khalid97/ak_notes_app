import 'package:ak_notes_app/features/notes/data/models/note_model.dart';
import 'package:ak_notes_app/features/notes/presentation/pages/edit_note.page.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/color.dart';


class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note, this.deleteEvent});

  final NoteModel note;
  final void Function()? deleteEvent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return  EditNotePage(note: note,);
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
                          Icons.note_outlined,
                          color: kPrimaryColor,
                          size: 14,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(note.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Text(
                note.content!,
                style: const TextStyle(height: 1.2),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 8,
              )
            ],
          ),
        ));
  }
}
