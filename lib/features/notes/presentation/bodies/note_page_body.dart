

import 'dart:async';

import 'package:ak_notes_app/core/error/error_message_filter.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/add_update_delete_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/note_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../../app_local.dart';
import '../../../../core/dialogs/alert_dialoge.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';


import '../widgets/loading_widget.dart';

class NotesPageBody extends StatefulWidget {
  const NotesPageBody({super.key});
  @override
  State<NotesPageBody> createState() => _NotesPageBodyState();
}

class _NotesPageBodyState extends State<NotesPageBody> {
  final StreamController<int> _controller = StreamController<int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     context.read<NoteProvider>().streamNote(FirebaseAuth.instance.currentUser!.uid);
    //   }
    // });

  }
  @override
  Widget build(BuildContext context) {

    return
      StreamBuilder(stream: context.watch<NoteProvider>().streamNote(FirebaseAuth.instance.currentUser!.uid),
        builder: (context , snapshot){

          if(snapshot.connectionState== ConnectionState.waiting){
            return const LoadingWidget();
          }
          else{
            if(snapshot.hasError){
              return Expanded(child: Center(child: Text(AppLocal.loc.error),));
            }else if(snapshot.hasData && snapshot.data!.isNotEmpty) {
              return     Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  crossAxisCount: 4,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Dismissible(
                          direction: DismissDirection.startToEnd,
                          key: Key('note-${ snapshot.data![index].id}-$index'),
                          child: NoteItem(note:  snapshot.data![index], deleteEvent: () {}),
                          confirmDismiss: (direction) async {
                            bool shouldDismiss = await AlertDialoge()
                                .showAlertDialog(context);
                            return shouldDismiss ?? false;
                          },
                          onDismissed: (direction) async {
                            await context.read<AddUpdateDeleteProvider>().deleteNote( FirebaseAuth.instance.currentUser!.uid , snapshot.data![index]).then((onValue){
                              SnackBarDialoge.showSnackBar(
                                  icon: Icons.error,
                                  bgColor: Colors.red,
                                  messageColor: Colors.white,
                                  context,
                                  message: AppLocal.loc.deletedSuccessfully);
                            }).catchError((onError){
                              print("OnError"+ onError.toString());
                              SnackBarDialoge.showSnackBar(
                                  icon: Icons.error,
                                  bgColor: Colors.red,
                                  messageColor: Colors.white,
                                  context,
                                  message: errorMessage(onError));

                            });

                          },
                        ),
                      ),
                  staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
                ),
              );
            }
            else{
              return  Expanded(child: Center(child: Text(AppLocal.loc.noNotes),),);
            }

          }

        });
  }


}









