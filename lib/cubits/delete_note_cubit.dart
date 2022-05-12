

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

  Future<void> deleteNote(NoteResponse note) async {
    emit(DeleteNotesInitial());
    await notesRepository.deleteNote(note);
    emit(DeleteNotesLoaded());
  }
}