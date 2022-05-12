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

  bool _isComposingTitle = false;
  bool _isComposingContent = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('new note'),
          backgroundColor: Colors.yellow[750],
        ),
        body:
        BlocListener<AddNoteCubit, AddNoteState>(
          bloc: addNoteCubit,
      listener: (context, state) {
            if(state is NotesInitial){
              const Text('loading');
            } if(state is NotesLoaded){
              Navigator.pushReplacementNamed(context, '/');
            }
      },
      child: Form(
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

                    Note note = Note(title: _titleController.text,content: _contentController.text);
                    if (_formKey.currentState!.validate()) {
                      addNoteCubit.addNote(note);
                      _titleController.clear();
                      _contentController.clear();
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
