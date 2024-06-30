

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/views/widgets/note_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';
import 'constants/color_name.dart';

class NoteView extends StatelessWidget {
   NoteView({super.key});

  final User? user = AuthController().currentUser;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:   const NotesViewBody(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed(RouteManager.addNoteView);

        // showModalBottomSheet(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //     context: context,
        //     builder: (context){
        //   return AddNoteBottomSheet();
        // });
      } ,

      backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        child: const  Icon(Icons.add , color: kWhiteColor,),
      )
    );
  }
}





