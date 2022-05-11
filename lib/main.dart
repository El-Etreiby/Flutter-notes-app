import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_cubit/pages/add_note_screen.dart';
import 'package:notes_with_cubit/pages/edit_note_screen.dart';
import 'package:notes_with_cubit/pages/home_page.dart';
import 'package:notes_with_cubit/repositories/note_repo.dart';

import 'cubits/add_notes_cubit.dart';
import 'cubits/delete_note_cubit.dart';
import 'cubits/edit_note_cubit.dart';
import 'locator.dart';


//dependency injection + connect to backend with spring


void main() {

  setup();
  runApp(
    NotesApp(),
  );
}

final ThemeData notesTheme = ThemeData(
  primarySwatch: Colors.yellow,
  primaryColor: Colors.grey[800],
  primaryColorBrightness: Brightness.light,
);


class NotesApp extends StatelessWidget {

  const NotesApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddNoteCubit(locator())),
        BlocProvider(create: (context) => DeleteNoteCubit(locator())),
        BlocProvider(create: (context) => EditNoteCubit(locator())),
      ],

          //inject cubits, naming conventions, seperate backend calls(Repo), http calls.

          child: MaterialApp(
            // home: const HomePage(),
            theme: notesTheme,
            routes: {
              '/add-note': (context) => const AddNoteScreen(),
              '/edit-note': (context) => const EditNoteScreen(),
              '/': (context) => HomePage(),
            },
            initialRoute: '/',
          ),
    );
  }
}
