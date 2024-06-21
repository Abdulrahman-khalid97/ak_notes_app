

import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:ak_notes_app/views/dialogs/snack_bar_dialoge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/collection_name.dart';
import '../constants/color_name.dart';
import 'custom_app_bar.dart';
import 'custom_text_field.dart';

class AddNoteViewBody extends StatelessWidget {
  const AddNoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return   _AddNoteForm() ;
  }
}

class _AddNoteForm extends StatefulWidget {
  const _AddNoteForm({super.key});

  @override
  State<_AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<_AddNoteForm> {


  // NotesController notesController = NotesController();
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title , content;
  NoteModel? note;
  @override
  Widget build(BuildContext context) {
    final firestoreProvidr = Provider.of<FirebaseController>(context);
    return
      Scaffold(
        body : Padding(
          padding:const  EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CustomAppBar(tille: "Add Note", icon: Icons.arrow_right_alt_outlined,onIconPressed: (){
                Navigator.pop(context);
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
                    onSaved: (value){
                      title= value;
                    },)
                  ,
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(hint: "Content" , maxLines: 5,
                    onSaved: (value){
                      content= value;
                    },) ,
                ],
                      ),
                    ),
              ),
            ],
          ),
        ) ,
        floatingActionButton: FloatingActionButton(onPressed: (){
          if(_frmKey.currentState!.validate()){
            _frmKey.currentState!.save();
            note = NoteModel(title: title!, content: content! ,date: FieldValue.serverTimestamp());
            firestoreProvidr.add( note:note).then((value){

              SnackBarDialoge.showSnackBar(
               icon: Icons.check_circle,
                 bgColor: Colors.green,
                 messageColor: Colors.white,
                 context,
                 message: successAddedMsg);
             //Navigator.pop(context);
            }).catchError((error){

              SnackBarDialoge.showSnackBar(
                  icon: Icons.error,
                  bgColor: Colors.red,
                  messageColor: Colors.white,
                  context,
                  message: successAddedMsg);
            });

            // notesController.storeNote(NoteModel(id: null, title: title!, content: content!, date: "", color: 2));


          }else{
            autovalidateMode= AutovalidateMode.always;
          }
        },
          child: Icon(Icons.check_rounded , color: kWhiteColor,),
          backgroundColor: kPrimaryColor,
          shape: CircleBorder(),
        ),
      );
  }
}



class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap});

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: kPrimaryColor ,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text("Save" , style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}