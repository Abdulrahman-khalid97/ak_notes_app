

import 'dart:async';

import 'package:ak_notes_app/core/error/error_message_filter.dart';
import 'package:ak_notes_app/core/style/color.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/add_update_delete_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/note_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../app_local.dart';
import '../../../../core/dialogs/alert_dialoge.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';


import '../../../../core/network/network.dart';
import '../../../../core/style/dimensional.dart';
import '../../../../injection_container.dart';
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
                  padding: const EdgeInsets.symmetric( vertical: kDefaultPadding),
                  crossAxisCount: 4,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Dismissible(
                          direction: DismissDirection.startToEnd,
                          key: Key('note-${ snapshot.data![index].id}-$index'),
                          child: NoteItem(note:  snapshot.data![index], deleteEvent: () {}),
                          confirmDismiss: (direction) async {
                            if(await NetworkInfoImpl(sl()).isConnected) {
                              return context.mounted ? await showDeleteAlert(
                                  context) ? true ?? false : false : false;
                            }
                            else{
                              if (context.mounted) {
                                SnackBarDialoge.showSnackBar(
                                  icon: Icons.signal_wifi_connected_no_internet_4_outlined,
                                  bgColor: kErrorColor,
                                  messageColor: kWhiteColor,
                                  context,
                                  message: AppLocal.loc.checkInternetConnection);
                              }
                              return false;
                              }

                          },
                          onDismissed: (direction) async {
                            await context.read<AddUpdateDeleteProvider>().deleteNote( FirebaseAuth.instance.currentUser!.uid , snapshot.data![index]).then((onValue){
                             return SnackBarDialoge.showSnackBar(
                                  icon: Icons.error,
                                  bgColor: Colors.red,
                                  messageColor: Colors.white,
                                  context,
                                  message: AppLocal.loc.deletedSuccessfully);
                            }).catchError((onError){
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









