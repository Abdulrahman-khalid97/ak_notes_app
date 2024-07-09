

import 'dart:async';

import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/notes/data/models/note_model.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/stream_notes.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/note.dart';

class NoteProvider extends ChangeNotifier{
 final GetAllNotesUseCase getAllNotesUseCase;
 final StreamNotes streamNotes;
 bool _initialNotes = false;
 bool _loadingNotes = false;
 bool _loadedNotes = false;
 bool _errorNotes = false;
 List<Note> _notes = [];
 String _errorMessage="";
 StreamSubscription<List<Note>>? subscription;
 Stream<List<Note>>? data;
 List<Note>? notesForSearch=[];

 bool get initialNotes => _initialNotes;

  NoteProvider({required this.getAllNotesUseCase , required this.streamNotes});

  Future<void> getNotes(String userId) async {

    try{
      _initialNotes = true;
      _loadingNotes = true;
      notifyListeners();
      final failureOrNots = await getAllNotesUseCase(userId);
      failureOrNots.fold(
          (failure){
            _errorMessage = _mapFailureToMessage(failure);
            _errorNotes = true;
            _loadingNotes = false;
            _loadedNotes = false;
            _initialNotes = false;
            _notes = [];
            notifyListeners();

          },
          (notes){
            _notes = notes;
            _loadingNotes = false;
            _loadedNotes = true;
            _errorNotes = false;
            _initialNotes = false;
            notifyListeners();
          });
    } catch(exp){

      _errorNotes = true;
      _loadingNotes = false;
      _loadedNotes = false;
      _initialNotes = false;
      _notes = [];

      notifyListeners();
    }



  }
 Future<List<Note>> refreshDelete(Note note) async {

    notes.remove(note);
    notifyListeners();

     return _notes;


 }

 Stream<List<Note>> streamNote(String userId){

    data= streamNotes(userId);
    subscription = data?.listen((List<Note> newNotes) {
      notesForSearch = newNotes;
      notifyListeners();
    });
    return data!;
 }
 bool get loadingNotes => _loadingNotes;

 bool get loadedNotes => _loadedNotes;

 bool get errorNotes => _errorNotes;

 List<Note> get notes => _notes;


 String get errorMessage => _errorMessage;

  @override
  void dispose() {
    // TODO: implement dispose
     //super.dispose();
  }
}

String _mapFailureToMessage(Failure failure){

  switch(failure.runtimeType){
    case ServerFailure:
      return "Server Failure";
    case EmptyCachedFailure:
      return "Empty Cached";
    default:
      return "UnExpected Error , Please try later";
  }
}