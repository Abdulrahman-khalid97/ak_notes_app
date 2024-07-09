

import 'package:ak_notes_app/app_local.dart';
import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/features/notes/domain/entities/note.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/add_note.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/delete_note.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/failure.dart';

class AddUpdateDeleteProvider extends ChangeNotifier{
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  bool _isFailure=false;

  bool _success=false;
  bool get isFailure => _isFailure;

  bool get success => _success;



  AddUpdateDeleteProvider({required this.addNoteUseCase, required this.deleteNoteUseCase, required this.updateNoteUseCase});

  Future<void> addNote(String userId , Note note)async{
    try{
      _isFailure = false;
      _success=false;
      notifyListeners();
       final failureOrDoneMessage = await addNoteUseCase(userId , note);
        failureOrDoneMessage.fold(
               (failure){

                _isFailure=true;
                _success=false;
                notifyListeners();
                throw  _mapFailureToMessage(failure);

               }, (_){
                 _isFailure=false;
                 _success=true;
                 notifyListeners();

       });
    }catch(exp){
      rethrow;
    }
  }

  Future<void> updateNote(String userId , Note note)async{
    try{
      final failureOrDoneMessage = await updateNoteUseCase(userId , note);
      failureOrDoneMessage.fold(
              (failure){
                throw _mapFailureToMessage(failure);
          }, (_){
      });
    }catch(exp){
      rethrow;
    }
  }
  Future<void> deleteNote(String userId , Note note)async{
    try{
      final failureOrDoneMessage = await deleteNoteUseCase(userId , note.id!);
      failureOrDoneMessage.fold(
              (failure){
                throw _mapFailureToMessage(failure);
          }, (_){
      });
    }catch(exp){
      rethrow;
    }
  }
}

 _mapFailureToMessage(Failure failure){
  switch(failure.runtimeType){
    case ServerFailure:
     throw ServerException();
    case EmptyCachedFailure:
     throw EmptyCacheException();
    case OffLineFailure:
      throw OffLineException();
    default:
    throw Exception();
  }
}