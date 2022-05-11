import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_with_cubit/locator.dart';

import '../models/note.dart';
import '../cubits/add_notes_cubit.dart';
import '../repositories/note_repo.dart';
import '../responses/note_response.dart';
import '../widgets/notes_card.dart';

import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AddNoteCubit addNoteCubit = locator();


  Future<List<NoteResponse>?>getNotes() async{
    return addNoteCubit.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: const Text('My notes'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        child: FutureBuilder<List<NoteResponse>?>(
          future: getNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            if(!snapshot.hasData){
              return const Center(child: Icon(Icons.error));
            }
            print("home");
            print(snapshot.data);
            return MasonryGridView.count(
              crossAxisCount: 4,
              itemCount: snapshot.data.length,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return NotesCard(note: snapshot.data[index]);
              },
            );
          }
        )
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.pushReplacementNamed(context, '/add-note');
    },
    tooltip: 'Add Note',
    child: const Icon(Icons.add),
    ),
    );
    //   body:  MasonryGridView.count(
    //     crossAxisCount: 4,
    //     itemCount: notes.length,
    //     mainAxisSpacing: 4,
    //     crossAxisSpacing: 4,
    //     itemBuilder: (context, index) {
    //       return NotesCard(note: notes[index]);
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.pushReplacementNamed(context, '/addnote');
    //     },
    //     tooltip: 'Add Note',
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}
