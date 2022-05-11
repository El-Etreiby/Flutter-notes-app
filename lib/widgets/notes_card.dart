// import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/delete_note_cubit.dart';
import '../models/note.dart';
import '../pages/edit_note_screen.dart';
import '../responses/note_response.dart';
import '../states/delete_note_state.dart';

import 'package:http/http.dart' as http;

class NotesCard extends StatelessWidget { //getNoteResponse must have id variable
  final NoteResponse note;

  const NotesCard({Key? key, required this.note}) : super(key: key);

  deleteNote(NoteResponse note) async{
    final url = Uri.parse('http://localhost:8080/deletenote');
    final request = http.Request("DELETE",url);
    request.headers.addAll(<String,String>{
      "Content-Type" : "application/json"
    });
    request.body = jsonEncode(note);
    final response = await request.send();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteNoteCubit, DeleteNoteState>(
      listener: (context, state) {
        if(state is DeleteNotesInitial){
          const Text('loading');
        } else if(state is DeleteNotesLoaded){
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
        ),
        child: Card(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          color: Colors.yellow,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(note.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[000],
                        )),
                    const SizedBox(height: 16.0),
                    Text(note.content,
                        style:
                        TextStyle(fontSize: 12.0, color: Colors.grey[800])),
                    Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            tooltip: 'edit note',
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditNoteScreen(),
                                  settings: RouteSettings(
                                    arguments: note,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            tooltip: 'delete note',
                            color: Colors.red,
                            onPressed: () {
                              Note toBeSent = Note(title: note.title, content: note.content);
                              BlocProvider.of<DeleteNoteCubit>(context).deleteNote(toBeSent, note.id);
                              deleteNote(note);
                            },
                          ),
                        ]),
                  ])),
        ),
      ),
    );
  }

}
