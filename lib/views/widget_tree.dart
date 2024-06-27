
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/models/user_model.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/notes_view.dart';
import 'package:ak_notes_app/views/verfication_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);

    return StreamBuilder(
        stream: auth.authStateChanges,
        builder: (context , snapshot){
          if(snapshot.connectionState== ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return const Center(
              child:  Text("Error"),
            );
          }
          else{
            if(snapshot.data==null){
              return const LoginView();
            }
            else{
              if(snapshot.data?.emailVerified==true){
                return  NoteView();
              }

                return const VerficationView();

            }
          }
        });
  }
}
