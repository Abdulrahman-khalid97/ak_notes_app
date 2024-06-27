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
    final notesController = Provider.of<NotesController>(context);

    return StreamProvider<List<NoteModel>>.value(
        lazy: true,
      value: notesController.streamNotes(FirebaseAuth.instance.currentUser!.uid),
      initialData: [],
        child: Consumer<List<NoteModel>>(
          builder: (BuildContext context, List<NoteModel> notes, Widget? child) {
            if(notes.isEmpty){
              return const Center(
                child: Text("There is no notes yet"),
              );
            }
            else {
              return  StaggeredGridView.countBuilder(
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            crossAxisCount: 4,
                            physics: const BouncingScrollPhysics(),
                            itemCount: notes.length,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child:  Dismissible(
                                    direction: DismissDirection.startToEnd,
                                    key: Key('note-${notes[index].id}-$index'),
                                    // ValueKey<String>(data[index].id.toString()),
                                    // Key(data[index].id.toString()),
                                    child: NoteItem(note: notes[index], deleteEvent: () {}),
                                    confirmDismiss: (direction) async {
                                      bool shouldDismiss = await AlertDialoge()
                                          .showAlertDialog(context);
                                      return shouldDismiss ?? false;
                                    },
                                    onDismissed: (direction)  async {
                                      await notesController.delete(notes[index]);
                                      notes.removeAt(index);
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

        ),
        );

    //   StreamProvider<List<NoteModel>>.value(
    //   value: context.read<FirebaseController>().fetchNotes(),
    //   initialData:const [],
    //   child:
    //   Consumer<List<NoteModel>>(
    //     builder: (context, data, child) {
    //       if (data.isEmpty) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (data.isNotEmpty) {
    //         return
    //           StaggeredGridView.countBuilder(
    //           crossAxisSpacing: 12,
    //           mainAxisSpacing: 12,
    //           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    //           crossAxisCount: 4,
    //           physics: const BouncingScrollPhysics(),
    //           itemCount: data.length,
    //           itemBuilder: (context, index) =>
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 4),
    //                 child: Dismissible(
    //                   direction: DismissDirection.startToEnd,
    //                   key: Key('note-${data[index].id}-$index'),
    //                   // ValueKey<String>(data[index].id.toString()),
    //                   // Key(data[index].id.toString()),
    //                   child: NoteItem(note: data[index], deleteEvent: () {}),
    //                   confirmDismiss: (direction) async {
    //                     bool shouldDismiss = await AlertDialoge()
    //                         .showAlertDialog(context);
    //                     return shouldDismiss ?? false;
    //                   },
    //                   onDismissed: (direction)  async {
    //                      await fireStoreProvider.delete(data[index]);
    //                      data.removeAt(index);
    //
    //                      SnackBarDialoge.showSnackBar(
    //                           icon: Icons.error,
    //                           bgColor: Colors.red,
    //                           messageColor: Colors.white,
    //                           context,
    //                           message: "Have deleted Successfully");
    //
    //
    //
    //
    //                   },
    //                 ),
    //               ),
    //           staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
    //         );
    //       }
    //       else if (data.isEmpty) {
    //         return Center(
    //           child: Text(
    //               "There is no Notes yet :  ${FirebaseAuth.instance.currentUser!.displayName}"),
    //         );
    //       }
    //       else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );

    //   StreamBuilder(
    //       stream: FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(FirebaseAuth.instance.currentUser!.uid).collection(NOTES_COLLECTION).snapshots(),
    //       builder: (context , snapshot){
    //         if(snapshot.hasData){
    //           return Center(
    //             child: Text(snapshot.data!.size.toString()),
    //           );
    //         }
    //         else if(snapshot.connectionState == ConnectionState.waiting){
    //           return Center(child: const CircularProgressIndicator());
    //         }
    //         else if(snapshot.hasError){
    //           return Center(
    //             child: Text("Error"),
    //           );
    //         }
    //         else{
    //           return ListView.builder(
    //             itemCount: snapshot.data!.docs.length,
    //             itemBuilder: (context, index) {
    //               final childDoc = snapshot.data!.docs[index];
    //
    //               // Use the childData map to display the data in your UI
    //               return Text('  ');
    //             },
    //           );
    //         }
    //
    //       });
    //   FutureBuilder(
    //   future: FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(FirebaseAuth.instance.currentUser!.uid).collection(NOTES_COLLECTION).snapshots(),
    //       //
    //       builder:(ctx , snapshots) {
    //   if (snapshots.connectionState == ConnectionState.done) {
    //     return StaggeredGridView.countBuilder(
    //       crossAxisSpacing: 12,
    //       mainAxisSpacing: 12,
    //       padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    //       crossAxisCount: 4,
    //       physics: BouncingScrollPhysics(),
    //       itemCount: snapshots.data!.length,
    //       itemBuilder: (context, index) =>
    //            Padding(
    //              padding:  EdgeInsets.symmetric(vertical: 4),
    //              child: NoteItem(note: snapshots.data![index] ,
    //                  deleteEvent: (){
    //                notesController.deleteNote(snapshots.data![index]);
    //                           }),
    //                         ),
    //       staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
    //     );
    //   }
    //   else {
    //     return Center(child: CircularProgressIndicator(),);
    //   }
    // });
    //
    //   FutureBuilder(future: notesController.loadNotes(), builder: (ctx  , snapshots){
    //   if(snapshots.connectionState== ConnectionState.done){
    //     return Padding(
    //       padding:  EdgeInsets.symmetric(vertical: 8),
    //       child: ListView.builder(
    //           padding: EdgeInsets.zero,
    //           itemCount: snapshots.data!.length,
    //           itemBuilder: (ctx , index){
    //             return Padding(
    //               padding:  EdgeInsets.symmetric(vertical: 4),
    //               child: NoteItem(note: snapshots.data![index] , deleteEvent: (){
    //                  notesController.deleteNote(snapshots.data![index]);
    //               }),
    //             );
    //
    //           }),
    //     );
    //   }else
    //   {
    //     return Center(child: CircularProgressIndicator(),);
    //   }
    // });
  }
}

// class NotesListView extends StatefulWidget {
//   const NotesListView({super.key});
//
//
//   @override
//   State<NotesListView> createState() => _NotesListViewState();
// }
//
// class _NotesListViewState extends State<NotesListView> {
//   NotesController notesController = NotesController();
//   List<NoteModel>? retrievedNotesList;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//        }
// }
