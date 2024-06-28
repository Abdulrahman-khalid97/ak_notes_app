import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/firebase_options.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/services/database_service.dart';
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
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<DatabaseService>(create: (_) => DatabaseService()),
          Provider<AuthController>(create: (_)=>AuthController()),
         Provider<UserController>(create: (_) => UserController()),
          Provider<NotesController>(create: (_) => NotesController()),
        // ChangeNotifierProvider<UserController>(create: (_)=>UserController(),)

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
            home: const WidgetTree(),
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

  }
}
