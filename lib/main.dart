import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:ak_notes_app/firebase_options.dart';
import 'package:ak_notes_app/views/login_view.dart';
import 'package:ak_notes_app/views/notes_view.dart';
import 'package:ak_notes_app/views/verfication_view.dart';
import 'package:ak_notes_app/views/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/app_state.dart';

late AppState appState;
void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp( const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {

    return
        MultiProvider(providers: [
          Provider<AppState>(create: (_) => AppState()),
          Provider<FirebaseController>(create: (_ ) => FirebaseController()),
        ],
    child: ChangeNotifierProvider(
      create: (context)=>AppState() ,
      child: Selector<AppState , Brightness>(
        builder: (ctx , value , child){
         return MaterialApp(
            theme: ThemeData(
                brightness: value,
                fontFamily: "Poppins"
            ),
            home: WidgetTree(),
            // WidgetTree(),
            // NoteView(),
            debugShowCheckedModeBanner: false,
          );
        },
        selector: (ctx, myAppSate){
          myAppSate.getState();
          return myAppSate.themeMode!;
        }
      )
    )
        );
    //   ChangeNotifierProvider(create: (_)=>FirestoreProvider() ,
    // child: MaterialApp(
    //   theme: ThemeData(
    //       brightness: Brightness.light,
    //       fontFamily: "Poppins"
    //   ),
    //   home: const NoteView(),
    //   debugShowCheckedModeBanner: false,
    // ),);
  }
}
