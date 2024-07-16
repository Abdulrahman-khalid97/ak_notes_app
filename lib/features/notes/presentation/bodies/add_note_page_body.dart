
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/style/dimensional.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/add_update_delete_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/contentTextField.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/title_text_field.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/dialogs/snack_bar_dialoge.dart';
import '../../../../core/error/error_message_filter.dart';
import '../../../../core/strings/color.dart';
import '../../domain/entities/note.dart';
import '../widgets/custom_app_bar.dart';


class AddNotePageBody extends StatelessWidget {
  const AddNotePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return   const _AddNoteForm() ;
  }
}

class _AddNoteForm extends StatefulWidget {
  const _AddNoteForm({super.key});
  @override
  State<_AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<_AddNoteForm> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // NotesController notesController = NotesController();
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title , content;
  Note? note;
  @override
  Widget build(BuildContext context) {
    AppLocal.init(context);
    return
      Scaffold(
        body : ChangeNotifierProvider(
          create: (_)=> context.read<AddUpdateDeleteProvider>(),
          child: Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: kAppBarUp,
                ),
                _buildAppBar(context),
                Expanded(
                  child: Form(
                    key: _frmKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      children:  [
                        const SizedBox(
                          height: 30,
                        ),
                        TitleTextFieldTextField(hint: AppLocal.loc.title,
                          onSaved: (value){
                            title= value;
                          },)
                        ,
                        const SizedBox(
                          height: 24,
                        ),
                        ContentTextFied(hint: AppLocal.loc.content ,
                          onSaved: (value){
                            content= value;
                          },) ,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ,
        floatingActionButton: FloatingActionButton(onPressed: ()async{
          if(_frmKey.currentState!.validate()){
            _frmKey.currentState!.save();
            note = Note( title: title!, content: content! ,createdAt: Timestamp.fromDate(DateTime.now()) , updateAt:Timestamp.fromDate(DateTime.now()));
             await context.read<AddUpdateDeleteProvider>().addNote(context.read<AuthenticationProvider>().user!.uid, note!).then((value) {
                context.read<NoteProvider>().getNotes(context.read<AuthenticationProvider>().user!.uid);
               SnackBarDialoge.showSnackBar(context , message: AppLocal.loc.addSuccessfully ,
               bgColor: Colors.greenAccent, messageColor: Colors.black ,icon: Icons.check);
                Navigator.of(context).pop();
             }).catchError((onError){
               SnackBarDialoge.showSnackBar(context , message: errorMessage(onError) ,
                   bgColor: Colors.red, messageColor: kWhiteColor ,icon: Icons.error_outline);
             });

          }else{
            autoValidateMode= AutovalidateMode.always;
          }
        },
          backgroundColor: Colors.blueGrey,
          shape: const CircleBorder(),
          child: const Icon(Icons.check , color: Colors.white,) ,
        ),
      );
  }


}


Widget _buildAppBar(BuildContext context){

  return  CustomAppBarBack(title: "${AppLocal.loc.add} ${AppLocal.loc.note}",);
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
