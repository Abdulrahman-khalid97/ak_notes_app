
import 'package:ak_notes_app/core/network/network.dart';
import 'package:ak_notes_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ak_notes_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:ak_notes_app/features/auth/data/repositiories/auth_repository_impl.dart';
import 'package:ak_notes_app/features/auth/data/repositiories/user_repository_impl.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ak_notes_app/features/auth/domain/repositories/user_repository.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/add_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/delete_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_in_email_password.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_out.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/sign_up_email_password.dart';
import 'package:ak_notes_app/features/auth/domain/usecases/update_user.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/authentication_provider.dart';
import 'package:ak_notes_app/features/auth/presentation/provider/user_crud_provider.dart';
import 'package:ak_notes_app/features/notes/data/datasources/note_local_data_source.dart';
import 'package:ak_notes_app/features/notes/data/datasources/note_remote_data_source.dart';
import 'package:ak_notes_app/features/notes/data/repositories/note_repository_impl.dart';
import 'package:ak_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/add_note.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/delete_note.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/stream_notes.dart';
import 'package:ak_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/add_update_delete_provider.dart';
import 'package:ak_notes_app/features/notes/presentation/provider/note_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async{

  // Provider
  sl.registerFactory(()=>NoteProvider(getAllNotesUseCase: sl(), streamNotes: sl()));
  sl.registerFactory(()=>AddUpdateDeleteProvider(addNoteUseCase: sl() , deleteNoteUseCase: sl() , updateNoteUseCase: sl()));
  sl.registerFactory(()=>AuthenticationProvider(signUpEmailPassword: sl(), signInEmailPasswordUseCase: sl(), signOutUseCase: sl(), getCurrentUserUseCase: sl(), getAuthStateChangeUseCase: sl()));
  sl.registerFactory(()=> UserCrudProvider(addUserUseCase: sl(), updateUserUseCase: sl(), deleteUserUseCase: sl(), getUserInfoUseCase: sl()));

      //UseCases
  sl.registerLazySingleton(()=>GetAllNotesUseCase( repository: sl()));
  sl.registerLazySingleton(()=>StreamNotes( repository: sl()));
  sl.registerLazySingleton(()=>AddNoteUseCase( repository: sl()));
  sl.registerLazySingleton(()=>DeleteNoteUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateNoteUseCase(repository: sl()));

  sl.registerLazySingleton(()=>SignInEmailPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(()=>SignUpEmailPassword(repository: sl()));
  sl.registerLazySingleton(()=>SignOutUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetAuthStateChangeUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetCurrentUserUseCase(repository: sl()));


  sl.registerLazySingleton(()=>AddUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>DeleteUserUseCase(repository: sl()));
  sl.registerLazySingleton(()=>GetUserInfoUseCase(repository: sl()));


  // Repository
  sl.registerLazySingleton<NotesRepository>(()=>NoteRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl()
  ));

  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      userRemoteDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<UserRepository>(()=>UserRepositoryImpl(
    networkInfo: sl(),
    userRemoteDataSource: sl()
  ));

  // DateSource
  sl.registerLazySingleton<NoteRemoteDataSource>(()=>NoteRemoteDataSourceWithFire(db:sl()));
  sl.registerLazySingleton<NoteLocalDataSource>(()=>NoteLocalDataSourceWithSPImpl(sharedPreferences:sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(()=>UserRemoteDataSourceFB(db:sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceFB(firebaseAuth: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(sl()));


  //Externat
  final sharedPreferences =await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=> sharedPreferences);
  sl.registerLazySingleton(()=> FirebaseFirestore.instance);
  sl.registerLazySingleton(()=> FirebaseAuth.instance);

  sl.registerLazySingleton(()=>InternetConnectionChecker());
}