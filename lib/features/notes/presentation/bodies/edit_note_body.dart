
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/error/error_message_filter.dart';

import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/contentTextField.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/title_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/dialogs/snack_bar_dialoge.dart';

import '../../../../core/style/dimensional.dart';
import '../../domain/entities/note.dart';
import '../provider/add_update_delete_provider.dart';
import '../provider/note_provider.dart';
import '../widgets/custom_app_bar.dart';

class EditNoteBody extends StatefulWidget {
  const EditNoteBody({super.key,required this.note});
  final Note? note;

  @override
  State<EditNoteBody> createState() => EditNoteBodyState();
}

class EditNoteBodyState extends State<EditNoteBody> {
  final GlobalKey<FormState> _frmKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? title, content;


  @override
  Widget build(BuildContext context) {
    title = widget.note!.title;
    content = widget.note!.content;
    AppLocal.init(context);
    return ChangeNotifierProvider(
        create: (_) => context.read<AddUpdateDeleteProvider>(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalBodyPadding),
          child: Column(
            children: [
              const SizedBox(
                height: kAppBarUp,
              ),
            _buildAppBar(context),


              // },) ,
              Expanded(
                child: Form(
                  key: _frmKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TitleTextFieldTextField(hint: AppLocal.loc.title,
                        textValue: widget.note!.title!,
                        onSaved: (value) {
                          title = value;
                        },
                        onChanged: (value) {
                          title = value;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ContentTextFied(hint: AppLocal.loc.content,
                        textValue: widget.note!.content!,
                        onSaved: (value) {
                          content = value;
                        }, onChanged: (value) {
                          content = value;
                        },),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
  Widget _buildAppBar(BuildContext context){
 return   CustomAppBarEdit(
     title: "${AppLocal.loc.edit} ${AppLocal.loc.theNote}",
     onIconPressed: () async {
       if (_frmKey.currentState!.validate()) {
         _frmKey.currentState!.save();
         if (widget.note!.title != title ||
             widget.note!.content != content) {
           final editedNote = Note(title: title,
               content: content,
               createdAt: widget.note!.createdAt,
               updateAt: Timestamp.fromDate(DateTime.now()),
               id: widget.note!.id);
           await context.read<AddUpdateDeleteProvider>()
               .updateNote(
               FirebaseAuth.instance.currentUser!.uid, editedNote)
               .then((value) {
             context.read<NoteProvider>().getNotes(
                 FirebaseAuth.instance.currentUser!.uid);

             SnackBarDialoge.showSnackBar(context,
                 message: AppLocal.loc.updatedSuccessfully,
                 bgColor: Colors.greenAccent,
                 messageColor: Colors.black,
                 icon: Icons.check);
             Navigator.of(context).pop();
           }).catchError((error) {

             SnackBarDialoge.showSnackBar(context,
                 message: errorMessage(error),
                 bgColor: Colors.red,
                 messageColor: Colors.white,
                 icon: Icons.error_outline);
           });

         }
         else {
           Navigator.of(context).pop();
         }
       } else {
         autoValidateMode = AutovalidateMode.always;
       }
     });
  }

  String _messageException(dynamic failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppLocal.loc.offLineError;
      case EmptyCachedFailure:
        return AppLocal.loc.emptyCached;
      case OffLineFailure:
        return AppLocal.loc.offLineError;
      default:
        return AppLocal.loc.unExpectedError;
    }
  }

}
