
import 'dart:convert';
import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/features/notes/data/models/note_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/strings/db_string.dart';

abstract class NoteLocalDataSource{
  Future<List<NoteModel>> getCachedNotes();
  Future<Unit> cacheNotes(List<NoteModel> noteModels);
}

class NoteLocalDataSourceWithSPImpl extends NoteLocalDataSource{
  final SharedPreferences sharedPreferences;

  NoteLocalDataSourceWithSPImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheNotes(List<NoteModel> noteModels)  {
    List noteModelsToJson = noteModels.map<Map<String , dynamic>>((noteModel)=> noteModel.toJson()).toList();

   //sharedPreferences.setString(CACHED_NOTE , json.encode(noteModelsToJson));

    return Future.value(unit);
  }
  @override
  Future<List<NoteModel>> getCachedNotes() {
    final jsonString = sharedPreferences.getString(CACHED_NOTE);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<NoteModel> jsonToNoteModels = decodeJsonData.map<NoteModel>((jsonNoteMode)=>NoteModel.localFromJson(jsonNoteMode)).toList();
      return Future.value(jsonToNoteModels);
    }
    else{
      throw EmptyCacheException();
    }
  }


}