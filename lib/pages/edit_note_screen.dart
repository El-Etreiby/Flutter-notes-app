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



  final _formKey = GlobalKey<FormState>();


  Future<Note> editNote(String title, String content, BuildContext context, int id) async {
    Note toBeSent = Note(content: content, title: title);
    editNoteCubit.editNote(toBeSent,id);
    Future<Note> result = Future(() => toBeSent);
    return result;
  }

  void _handleSubmitted(String title, String content) {
    _titleController.clear();
    _contentController.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final oldNote = ModalRoute.of(context)!.settings.arguments as NoteResponse;
    _titleController.value = TextEditingValue(
      text: oldNote.title,
      selection: TextSelection.fromPosition(
        TextPosition(offset: oldNote.title.length),
      ),
    );
    _contentController.value = TextEditingValue(
      text: oldNote.content,
      selection: TextSelection.fromPosition(
        TextPosition(offset: oldNote.content.length),
      ),
    );
    return BlocListener<EditNoteCubit, EditNoteState>(
  listener: (context, state) {
    if(state is EditNotesInitial){
      const Text('loading');
    } if(state is EditNotesLoaded){
      Navigator.pushReplacementNamed(context, '/');
    }
  },
  child: Scaffold(
      appBar: AppBar(
        title: const Text('edit note'),
        backgroundColor: Colors.yellow[750],
      ),
      body: Form(
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
                    Note note = await editNote(_titleController.text, _contentController.text,context, oldNote.id);
                   Note toBeSent = Note(title: note.title, content: note.content);
                    _handleSubmitted(
                        _titleController.text, _contentController.text);
                    BlocProvider.of<EditNoteCubit>(context).editNote(note, oldNote.id);
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
