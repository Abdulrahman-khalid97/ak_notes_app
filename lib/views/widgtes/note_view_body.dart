
import 'package:ak_notes_app/controllers/app_state.dart';
import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/controllers/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_app_bar.dart';
import 'custom_note_item.dart';
import 'custom_search.dart';
import 'notes_list_view.dart';


class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});
  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context , listen: true);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children:  [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: CustomAppBar(tille: "Note",icon: Icons.search_rounded,onThemeToggled: (){
                appState.toggleTheme(!appState.initialIsDarkMode!);
              }, isDark: appState.initialIsDarkMode! , onIconPressed: (){
                showSearch(
                    context: context, delegate: CustomSearchDelegate());
              },),
            ) ,

            const SizedBox(
              height: 5,
            ),
            Expanded(
              child:
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24)
                  ,child: NotesListView(),
              )
            )
          ],
        ),
      )
    ;
  }
}









