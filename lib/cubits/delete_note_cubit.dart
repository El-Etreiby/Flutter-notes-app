

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../locator.dart';
import '../models/note.dart';
import '../repositories/note_repo.dart';
import '../responses/note_response.dart';
import '../states/delete_note_state.dart';
import 'add_notes_cubit.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {

  final NotesRepository notesRepository;
  DeleteNoteCubit(this.notesRepository) : super(DeleteNotesInitial());

  void deleteNote(Note note, int id) async {
    emit(DeleteNotesInitial());
    String message = await notesRepository.deleteNote(note,id);
    List<NoteResponse> notesList = await notesRepository.getNotes();
    List<Note> toBeDisplayed = <Note>[];
    for(int i = 0; i < notesList.length; i++){
      toBeDisplayed.add(Note(title: notesList.elementAt(i).title,content: notesList.elementAt(i).content));
    }
    emit(DeleteNotesLoaded(toBeDisplayed));


  }
}