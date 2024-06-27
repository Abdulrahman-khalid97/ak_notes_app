
import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:flutter/material.dart';

import '../constants/color_name.dart';
import 'custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
   const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
       padding:  EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child:AddNoteForm(),
      )
    );
  }


}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  NotesController notesController = NotesController();
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title , content;
  @override
  Widget build(BuildContext context) {
    return  Form(
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
          },)  ,
          const SizedBox(height: 32,),
          CustomButton(onTap: (){
            if(_frmKey.currentState!.validate()){
              _frmKey.currentState!.save();
             // notesController.storeNote(NoteModel(id: null, title: title!, content: content!, date: "", color: 2));
            }else{
              autovalidateMode= AutovalidateMode.always;
            }
          },),
         const SizedBox(height: 24,)
        ],
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
        child: const Center(
          child: Text("Save" , style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}

