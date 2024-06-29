import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/controllers/user_controller.dart';
import 'package:ak_notes_app/firebase_options.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/services/database_service.dart';
import 'package:ak_notes_app/setting_provider.dart';
import 'package:ak_notes_app/shared_pref.dart';
import 'package:ak_notes_app/views/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/app_state.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref.getLang();
  await SharedPref.getState();
  runApp( const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {

    return
        MultiProvider(providers: [
          Provider<AuthService>(create: (_) => AuthService()),
          Provider<DatabaseService>(create: (_) => DatabaseService()),
          Provider<AuthController>(create: (_)=>AuthController()),
          Provider<UserController>(create: (_) => UserController()),
          Provider<NotesController>(create: (_) => NotesController()),
          ChangeNotifierProvider(create: (_)=>SettingProvider()) ,
        ],
    child:Builder(
      builder: (context){

        return MaterialApp(
          supportedLocales: L10n.all,
          locale: Locale(Provider.of<SettingProvider>(context).local ?? SharedPref.lang??AppLocal.loc.en),
          localizationsDelegates: AppLocalizations.localizationsDelegates ,
          theme: ThemeData(
              brightness: Provider.of<SettingProvider>(context).isDarkMode!? Brightness.dark : Brightness.light,
              fontFamily: "Poppins"
          ),
          home: const WidgetTree(),
          // WidgetTree(),
          // NoteView(),
          debugShowCheckedModeBanner: false,

        );
      },
    )
    // ChangeNotifierProvider(
    //   create: (context)=>AppState() ,
    //   child: Selector<AppState , Brightness>(
    //     builder: (ctx , value , child){
    //      return MaterialApp(
    //        supportedLocales: L10n.all,
    //         locale: Locale(),
    //         theme: ThemeData(
    //             brightness: value,
    //             fontFamily: "Poppins"
    //         ),
    //         home: const WidgetTree(),
    //         // WidgetTree(),
    //         // NoteView(),
    //         debugShowCheckedModeBanner: false,
    //
    //       );
    //     },
    //     selector: (ctx, myAppSate){
    //       myAppSate.getState();
    //       return myAppSate.themeMode!;
    //     }
    //   )
    // )
        );

  }
}
