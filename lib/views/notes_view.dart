

import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/views/add_note_view.dart';
import 'package:ak_notes_app/views/widgtes/add_note_bottom_sheet.dart';
import 'package:ak_notes_app/views/widgtes/note_view_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants/color_name.dart';

class NoteView extends StatelessWidget {
   NoteView({super.key});

  final User? user = AuthController().currentUser;

  Widget _userId(){
    return Text(user?.email ?? "User Email");
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:   NotesViewBody(),
      floatingActionButton: FloatingActionButton(onPressed: (){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)
      {
        return const AddNoteView();
      }));
        // showModalBottomSheet(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //     context: context,
        //     builder: (context){
        //   return AddNoteBottomSheet();
        // });
      } ,
      child: Icon(Icons.add , color: kWhiteColor,),
      backgroundColor: kPrimaryColor,
        shape: CircleBorder(),
      )
    );
  }
}





