
import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/widgets/custom_notes_search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/note.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:  const Icon( Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search logic here
    AppLocal.init(context);
    return Center(
      child: Text('${AppLocal.loc.searchSuggestionFor} $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<Note>? filteredList = [];
    filteredList = _filter(context.watch<NoteProvider>().notesForSearch!, query);
    // Implement your search suggestions here
    return
      filteredList!.isNotEmpty? ListView.builder(
          itemCount: filteredList.length ,
          itemBuilder: (context, index){
            if (filteredList!.isNotEmpty){
              return CustomNoteSearchItem(note: filteredList[index], deleteEvent: () {});
            }
            return Text(AppLocal.loc.noNotes);

          }) :   Center(
        child:
        Text('${AppLocal.loc.searchSuggestionFor} $query'),
      );

    //   Center(
    //   child:
    //
    //   //Text('Search suggestions for: $query'),
    // );
  }

  List<Note>?  _filter(List<Note> notes, String q) {
    List<Note>? filteredList=[];
    for (var note in notes) {
      if (note.title.toString().toLowerCase().contains(query.toLowerCase()) || note.content.toString().toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(note);
      }

    }
    return filteredList;
  }
}