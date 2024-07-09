
import 'package:ak_notes_app/features/auth/presentation/pages/widget_tree_page.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/add_update_delete_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:ak_notes_app/firebase_options.dart';
import 'package:ak_notes_app/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_local.dart';
import 'core/provider_setting.dart';
import 'core/shared_pref_setting.dart';
import 'l10n/l10n.dart';
import 'injection_container.dart' as di;


void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPref.getLang();
  await SharedPref.getState();
  runApp( const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SettingProvider()),
        Provider(create: (_)=>di.sl<NoteProvider>()),
        Provider(create: (_)=>di.sl<AddUpdateDeleteProvider>()),
        Provider(create: (_)=>di.sl<AuthenticationProvider>())
      ],
        child:Builder(
          builder: (context){

            return MaterialApp(
              supportedLocales: L10n.all,
              locale: Locale(Provider.of<SettingProvider>(context).local ?? SharedPref.lang??AppLocal.loc.en),
              localizationsDelegates: AppLocalizations.localizationsDelegates ,
              initialRoute: RouteManager.homePage,
              onGenerateRoute: RouteManager.generateRoute,
              theme: ThemeData(
                  brightness: Provider.of<SettingProvider>(context).isDarkMode ?? SharedPref.initialIsDarkMode!? Brightness.dark: Brightness.light,
                  fontFamily: "Poppins"
              ),
              home: const WidgetTree(),

              debugShowCheckedModeBanner: false,

            );
  }
      ),
    );
    //     MultiProvider(providers: [
    //       Provider<AuthService>(create: (_) => AuthService()),
    //       Provider<DatabaseService>(create: (_) => DatabaseService()),
    //       Provider<AuthController>(create: (_)=>AuthController()),
    //       Provider<UserController>(create: (_) => UserController()),
    //       Provider<NotesController>(create: (_) => NotesController()),
    //       ChangeNotifierProvider(create: (_)=>SettingProvider()) ,
    //     ],
    // child:Builder(
    //   builder: (context){
    //
    //     return MaterialApp(
    //       supportedLocales: L10n.all,
    //       locale: Locale(Provider.of<SettingProvider>(context).local ?? SharedPref.lang??AppLocal.loc.en),
    //       localizationsDelegates: AppLocalizations.localizationsDelegates ,
    //       initialRoute: RouteManager.widgetTreeView,
    //       onGenerateRoute: RouteManager.generateRoute,
    //       theme: ThemeData(
    //           brightness: Provider.of<SettingProvider>(context).isDarkMode!? Brightness.dark : Brightness.light,
    //           fontFamily: "Poppins"
    //       ),
    //       home: const WidgetTree(),
    //       // WidgetTree(),
    //       // NoteView(),
    //       debugShowCheckedModeBanner: false,
    //
    //     );
    //   },
    // )
    // // ChangeNotifierProvider(
    // //   create: (context)=>AppState() ,
    // //   child: Selector<AppState , Brightness>(
    // //     builder: (ctx , value , child){
    // //      return MaterialApp(
    // //        supportedLocales: L10n.all,
    // //         locale: Locale(),
    // //         theme: ThemeData(
    // //             brightness: value,
    // //             fontFamily: "Poppins"
    // //         ),
    // //         home: const WidgetTree(),
    // //         // WidgetTree(),
    // //         // NoteView(),
    // //         debugShowCheckedModeBanner: false,
    // //
    // //       );
    // //     },
    // //     selector: (ctx, myAppSate){
    // //       myAppSate.getState();
    // //       return myAppSate.themeMode!;
    // //     }
    // //   )
    // // )
    //     );

  }
}
