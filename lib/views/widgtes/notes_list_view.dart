import 'dart:async';
import 'dart:io';

import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/services/database_service.dart';
import 'package:ak_notes_app/views/dialogs/alert_dialoge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../controllers/notes_controller.dart';
import '../constants/collection_name.dart';
import '../dialogs/snack_bar_dialoge.dart';
import 'custom_note_item.dart';

class NotesListView extends StatelessWidget {
  NotesListView({super.key});

  void Function()? deleteTap;

  @override
  Widget build(BuildContext context) {
    final notesController = Provider.of<NotesController>(context , listen: true);

    return ChangeNotifierProvider(create: (_)=>notesController ,
      child: Consumer<NotesController>(
        builder: (context , notes , child){
          if(notes.notes!.isEmpty){
            return Center(
              child: Text("There is no data yet"),
            );
          }
          else{
            return StaggeredGridView.countBuilder(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              crossAxisCount: 4,
              physics: const BouncingScrollPhysics(),
              itemCount: notes.notes!.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: Key('note-${notes.notes![index].id}-$index'),
                      child: NoteItem(note: notes.notes![index], deleteEvent: () {}),
                      confirmDismiss: (direction) async {
                        print( notes.notes![index].id);
                        bool shouldDismiss = await AlertDialoge()
                            .showAlertDialog(context);
                        return shouldDismiss ?? false;
                      },
                      onDismissed: (direction) async {
                        await notesController.delete(notes.notes![index]);

                        SnackBarDialoge.showSnackBar(
                            icon: Icons.error,
                            bgColor: Colors.red,
                            messageColor: Colors.white,
                            context,
                            message: "Have deleted Successfully");
                      },
                    ),
                  ),
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            );
          }

        },
      )  ,);

      // StreamProvider<List<NoteModel>>.value(
      //   lazy: true,
      //   value: notesController.streamNotes(
      //       FirebaseAuth.instance.currentUser!.uid),
      //   initialData: const [],
      //   child: Consumer<List<NoteModel>>(
      //     builder: (BuildContext context, List<NoteModel> notes,
      //         Widget? child) {
      //       if (notes.isEmpty) {
      //         return const Center(
      //           child: Text("There is no notes yet"),
      //         );
      //       }
      //       else {
      //         return StaggeredGridView.countBuilder(
      //           crossAxisSpacing: 12,
      //           mainAxisSpacing: 12,
      //           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      //           crossAxisCount: 4,
      //           physics: const BouncingScrollPhysics(),
      //           itemCount: notes.length,
      //           itemBuilder: (context, index) =>
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(vertical: 4),
      //                 child: Dismissible(
      //                   direction: DismissDirection.startToEnd,
      //                   key: Key('note-${notes[index].id}-$index'),
      //                   child: NoteItem(note: notes[index], deleteEvent: () {}),
      //                   confirmDismiss: (direction) async {
      //                     print( notes[index].id);
      //                     bool shouldDismiss = await AlertDialoge()
      //                         .showAlertDialog(context);
      //                     return shouldDismiss ?? false;
      //                   },
      //                   onDismissed: (direction) async {
      //                     await notesController.delete(notes[index]);
      //
      //                     SnackBarDialoge.showSnackBar(
      //                         icon: Icons.error,
      //                         bgColor: Colors.red,
      //                         messageColor: Colors.white,
      //                         context,
      //                         message: "Have deleted Successfully");
      //                   },
      //                 ),
      //               ),
      //           staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      //         );
      //       }
      //     },
      //
      //   ),
      // );
  }
}