import 'package:ak_notes_app/controllers/notes_controller.dart';
import 'package:ak_notes_app/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_note_item.dart';
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
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final notesController = Provider.of<NotesController>(context , listen: true);
     List<NoteModel>? fillteredList = [];
    fillteredList = _filtter(notesController.notes!, query);
    // Implement your search suggestions here
    return
      fillteredList!.isNotEmpty? ListView.builder(
          itemCount: fillteredList!.length ,
          itemBuilder: (context, index) {
            if (fillteredList!.isNotEmpty){
              return NoteItem(note: fillteredList![index], deleteEvent: () {});
            }

          }) :   Center(
      child:
      Text('Search suggestions for: $query'),
    );

    //   Center(
    //   child:
    //
    //   //Text('Search suggestions for: $query'),
    // );
  }

  List<NoteModel>?  _filtter(List<NoteModel> notes, String q) {
    List<NoteModel>? fillteredList=[];
    for (var note in notes) {
      if (note.title.toLowerCase().contains(query.toLowerCase()) || note.content.toLowerCase().contains(query.toLowerCase())) {
       fillteredList.add(note);
      }

    }
    return fillteredList;
  }
}