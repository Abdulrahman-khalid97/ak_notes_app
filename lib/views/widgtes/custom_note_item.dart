import 'package:ak_notes_app/models/note_model.dart';
import 'package:flutter/material.dart';

import '../edit_note_view.dart';

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
                          Icons.star,
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
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Text(
               note.content,
                style: const TextStyle(height: 1.2),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 8,
              )
            ],
          ),
        ));
    // GestureDetector(
    //   onTap: (){
    //     Navigator.push(context, MaterialPageRoute(builder: (context){
    //       return const EditNoteView();
    //     }),
    //     );
    //   },
    //   child: Container(
    //
    //     padding: EdgeInsets.only(left: 16 , top: 16 , bottom: 16 ),
    //     decoration: BoxDecoration(
    //         borderRadius:  BorderRadius.circular(16),
    //         color: Colors.blue
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //
    //       children: [
    //
    //         ListTile(
    //           title:  Text(note.title , style: TextStyle(
    //               color: Colors.black,
    //               fontSize: 26
    //           ),),
    //           subtitle: Container(
    //             padding: EdgeInsets.only(top: 16),
    //             child: Text(note.content, style: TextStyle(
    //                 color: Colors.black.withOpacity(0.5) ,
    //                 fontSize: 16
    //             ),),
    //           ),
    //           trailing: IconButton(
    //
    //             onPressed: deleteEvent,
    //             icon: Icon(Icons.delete , size: 30,
    //               color: Colors.black,),
    //           ),
    //         ) ,
    //         Padding(
    //           padding: const EdgeInsets.only(right: 16 , bottom: 16),
    //           child: Text(note.date , style: TextStyle(
    //               color: Colors.black.withOpacity(0.5)  ,
    //               fontSize: 14
    //           ),),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
