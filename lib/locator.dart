import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_with_cubit/cubits/add_notes_cubit.dart';
import 'package:notes_with_cubit/repositories/note_repo.dart';

import 'RESTApi/api_client.dart';
import 'cubits/delete_note_cubit.dart';
import 'cubits/edit_note_cubit.dart';



final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<APIClient>(() => APIClient(Dio(
    BaseOptions(contentType: "application/json"),
  )));
  locator.registerLazySingleton<NotesRepository>(() => NotesRepository(
locator()
  ));


  locator.registerLazySingleton<AddNoteCubit>(() => AddNoteCubit(
      locator()
  ));

  locator.registerLazySingleton<EditNoteCubit>(() => EditNoteCubit(
      locator()
  ));

  locator.registerLazySingleton<DeleteNoteCubit>(() => DeleteNoteCubit(
      locator()
  ));
}
