
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../app_local.dart';
import '../../../../core/dialogs/alert_dialoge.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';

import '../../../../core/network/network.dart';
import '../../../../core/style/color.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/note.dart';
import '../provider/add_update_delete_provider.dart';
import '../provider/note_provider.dart';
import 'note_item.dart';

class NoteListView extends StatelessWidget {
  final List<Note> notes;

  NoteListView({super.key, required this.notes});

  void Function()? deleteTap;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => context.read<AddUpdateDeleteProvider>(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: StaggeredGridView.countBuilder(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          crossAxisCount: 4,
          physics: const BouncingScrollPhysics(),
          itemCount: notes.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              key: Key('note-${notes[index].id}-$index'),
              child: NoteItem(note: notes[index], deleteEvent: () {}),
              confirmDismiss: (direction) async {
                if(await NetworkInfoImpl(sl()).isConnected) {
                  return context.mounted ? await showDeleteAlert(
                      context) ? true ?? false : false : false;
                }
                else{
                  if (context.mounted) {
                    SnackBarDialoge.showSnackBar(
                        icon: Icons.signal_wifi_connected_no_internet_4_outlined,
                        bgColor: Colors.lightBlue,
                        messageColor: kPrimaryColor,
                        context,
                        message: AppLocal.loc.noValue);
                  }
                  return false;
                }
              },
              onDismissed: (direction) async {
               await  context
                    .read<AddUpdateDeleteProvider>()
                    .deleteNote(
                        FirebaseAuth.instance.currentUser!.uid, notes[index])
                    .then((value) {
                  context.watch<NoteProvider>().refreshDelete(notes[index]);
                  SnackBarDialoge.showSnackBar(
                      icon: Icons.error,
                      bgColor: Colors.red,
                      messageColor: Colors.white,

                      context,
                      message: AppLocal.loc.deletedSuccessfully);

                }).catchError((onError){
                  print(onError.runtimeType);
                  // SnackBarDialoge.showSnackBar(
                  //
                  //     icon: Icons.error,
                  //     bgColor: Colors.red,
                  //     messageColor: Colors.white,
                  //     context,
                  //     message: "${AppLocal.loc.error} : ${onError.hashCode}");

                });
              },
            ),
          ),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
        ),
      ),
    );
    ;
  }
}
