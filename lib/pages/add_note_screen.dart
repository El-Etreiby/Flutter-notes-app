import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../locator.dart';
import '../models/note.dart';
import '../cubits/add_notes_cubit.dart';



class AddNoteScreen extends StatefulWidget {


  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreen();
}


class _AddNoteScreen extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late final AddNoteCubit addNoteCubit = locator();


  Future<Note> addNote(String title, String content, BuildContext context) async {

    Note note = Note(content: content, title: title);
    // var response = addNoteCubit.addNote(note);
    Future<Note> result = Future(() => note);
    return result;
  }


  bool _isComposingTitle = false;
  bool _isComposingContent = false;

  final _formKey = GlobalKey<FormState>();

  void _handleSubmitted(String title, String content) {
    _titleController.clear();
    _contentController.clear();
    if (!_isComposingContent || !_isComposingTitle) {
      _isComposingTitle = false;
      _isComposingContent = false; // NEW
      return;
    }
    _isComposingTitle = false;
    _isComposingContent = false;

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNoteCubit, AddNoteState>(
      listener: (context, state) {
            if(state is NotesInitial){
              print('init state');
              const Text('loading');
            } if(state is NotesLoaded){
              Navigator.pushReplacementNamed(context, '/');
            }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('new note'),
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
                      _isComposingTitle = true;
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
                      _isComposingContent = true;
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
                    Icons.save,
                    color: Colors.grey[800],
                    size: 24.0,
                  ),
                  label: const Text('add note'),
                  onPressed: () async{

                    Note note = await addNote(_titleController.text, _contentController.text,context);

                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AddNoteCubit>(context).addNote(note);
                      _handleSubmitted(
                          _titleController.text, _contentController.text);
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
