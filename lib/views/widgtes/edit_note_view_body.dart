
import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/firebase_controller.dart';
import '../constants/collection_name.dart';
import '../constants/color_name.dart';
import '../dialogs/snack_bar_dialoge.dart';
import 'custom_app_bar.dart';
import 'custom_text_field.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key,required this.note});
  final NoteModel? note;

  @override
  State<EditNoteViewBody> createState() => EditNoteViewBodyState();
}

class EditNoteViewBodyState extends State<EditNoteViewBody> {
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title , content;
  @override
  Widget build(BuildContext context) {
    final notesController = Provider.of<NotesController>(context);
    return  Scaffold(
      body : Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CustomAppBar(tille: "Edit Note", icon: Icons.check,onIconPressed: (){

            widget.note!.title=title?? widget.note!.title;
            widget.note!.content=content?? widget.note!.content;

              notesController.update(widget.note!).then((value){
                SnackBarDialoge.showSnackBar(
                    icon: Icons.check_circle,
                    bgColor: Colors.green,
                    messageColor: Colors.white,
                    context,
                    message: successAddedMsg);
                  Navigator.pop(context);
              }).catchError((error)=>{
                SnackBarDialoge.showSnackBar(
                    icon: Icons.error,
                    bgColor: Colors.red,
                    messageColor: Colors.white,
                    context,
                    message: error.toString())
              });
            },) ,
            Expanded(
              child: Form(
                key: _frmKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children:  [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(hint: "Title",
                      textValue: widget.note!.title,
                      onSaved: (value){
                        title= value;
                      },
                      onChanged: (value){
                        title= value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(hint: "content" , maxLines: 5,
                      textValue: widget.note!.content,
                      onSaved: (value){
                        content= value;
                      },onChanged: (value){
                        content= value;
                      },) ,
                  ],
                ),
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}


