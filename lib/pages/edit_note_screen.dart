import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_cubit/states/edit_note_state.dart';

import 'package:http/http.dart' as http;
import '../cubits/edit_note_cubit.dart';
import '../locator.dart';
import '../models/note.dart';
import '../cubits/add_notes_cubit.dart';
import '../responses/note_response.dart';


class EditNoteScreen extends StatefulWidget {

  const EditNoteScreen({Key? key}) : super(key: key);
  @override
  State<EditNoteScreen> createState() => _EditNoteScreen();

}




class _EditNoteScreen extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  late final EditNoteCubit editNoteCubit = locator();
  late NoteResponse oldNote;


  final _formKey = GlobalKey<FormState>();
@override
  void initState(){
    super.initState();
    // oldNote = ModalRoute.of(context)!.settings.arguments as NoteResponse;
    //todo
    // _contentController.text=
    //scaffold wrapping whole page
    //
    // _titleController.value = TextEditingValue(
    //   text: oldNote.title,
    //   selection: TextSelection.fromPosition(
    //     TextPosition(offset: oldNote.title.length),
    //   ),
    // );
    // _contentController.value = TextEditingValue(
    //   text: oldNote.content,
    //   selection: TextSelection.fromPosition(
    //     TextPosition(offset: oldNote.content.length),
    //   ),
    // );
}

  Future<Note> editNote(String title, String content, BuildContext context, int id) async {
    Note toBeSent = Note(content: content, title: title);
    editNoteCubit.editNote(toBeSent,id);
    Future<Note> result = Future(() => toBeSent);
    return result;
  }


  @override
  Widget build(BuildContext context) {
    oldNote = ModalRoute.of(context)!.settings.arguments as NoteResponse;
_titleController.text=oldNote.title;
_contentController.text=oldNote.content;
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('edit note'),
          backgroundColor: Colors.yellow[750],
        ),

        body: BlocListener<EditNoteCubit, EditNoteState>(
          bloc: editNoteCubit,
  listener: (context, state) {
    if(state is EditNotesInitial){
      const Text('loading');
    } if(state is EditNotesLoaded){
      Navigator.pushReplacementNamed(context, '/');
    }
  },
  child:
       Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  controller: _titleController,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  controller: _contentController,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter the content';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey[800],
                  size: 24.0,
                ),
                label: const Text('edit note'),
                onPressed: () async {


                  if (_formKey.currentState!.validate()) {
                    Note note = Note(title: _titleController.text,content: _contentController.text);
                    _titleController.clear();
                    _contentController.clear();
                    editNoteCubit.editNote(note, oldNote.id);
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ),
);
  }
}
