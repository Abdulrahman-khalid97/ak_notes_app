

import 'package:ak_notes_app/core/error/exception..dart';
import 'package:ak_notes_app/core/error/failure.dart';
import 'package:ak_notes_app/features/notes/data/models/note_model.dart';
import 'package:ak_notes_app/features/notes/domain/entities/note.dart';
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network.dart';
import '../datasources/note_local_data_source.dart';
import '../datasources/note_remote_data_source.dart';

typedef DeleteOrUpdateOrAdd = Future<Unit> Function();


class NoteRepositoryImpl implements NotesRepository{

  //  Attributes
  final NoteRemoteDataSource remoteDataSource;
  final NoteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  //  Constructor
  NoteRepositoryImpl({required this.networkInfo, required this.remoteDataSource,required this.localDataSource});
  @override
  Future<Either<Failure, List<Note>>> getAllNotes(String userId) async {

    if(await networkInfo.isConnected){
      try{
        final remotePost = await remoteDataSource.getAllNote(userId);
       await localDataSource.cacheNotes(remotePost);

        return Right(remotePost);
      }on   ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
       final localPost= await localDataSource.getCachedNotes();
       return Right(localPost);
      }on EmptyCacheException{
        throw Left(EmptyCachedFailure());
      }
    }
  }
  @override
  Future<Either<Failure, Unit>> addNote(String userId, Note note) async {
    final NoteModel noteModel=NoteModel(
        title: note.title, content: note.content,
        createdAt: note.createdAt, updateAt: note.updateAt);

    return await _getMessage(()=> remoteDataSource.addNote(userId, noteModel));

    }

  @override
  Future<Either<Failure, Unit>> deleteNote(String userID, String noteId) async {
    return await _getMessage(()=> remoteDataSource.deleteNote(userID, noteId));
  }



  @override
  Future<Either<Failure, Unit>> updateNote(String userId, Note note) async {
    final NoteModel noteModel=NoteModel(id: note.id!,
        title: note.title, content: note.content,
        createdAt: note.createdAt, updateAt: note.updateAt);
    return await _getMessage(()=> remoteDataSource.updateNote(userId, noteModel));
  }


  /*  Function for implements the three Operation in Repo.  */

  Future<Either<Failure,Unit>>_getMessage(
      DeleteOrUpdateOrAdd  deleterOrUpdateOrAddNote) async{

    if(await networkInfo.isConnected){
      try{
         await deleterOrUpdateOrAddNote();
        return Right(unit);
      }on ServerException{

        return Left(ServerFailure());
      }
    }else{
      return Left(OffLineFailure());
    }
  }

  @override
  Stream<List<Note>> streamNotes(String userId) {
    return remoteDataSource.streamNotes(userId);
  }
}

