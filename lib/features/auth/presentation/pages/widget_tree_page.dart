

import 'dart:async';

import 'package:ak_notes_app/features/auth/presentation/pages/login_page.dart';
import 'package:ak_notes_app/features/auth/presentation/pages/verification_page.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/pages/note_page.dart';



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
   final auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: StreamBuilder(
          stream: auth.authChanges,
          builder: (context , snapshot){
            if(snapshot.connectionState== ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          if(snapshot.connectionState== ConnectionState.active){
              if(snapshot.hasError){
                return const Center(
                  child:  Text("Error"),
                );
              }
              else{
                if(snapshot.data==null){
                  return const LoginPage();
                }
                else{
                  if(snapshot.data?.emailVerified==true){

                    return const   NotesPage();

                  }
                  return const VerificationPage();

                }
              }
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          }),
    );
  }
}
