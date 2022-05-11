

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../locator.dart';
import '../models/note.dart';
import '../repositories/note_repo.dart';
import '../responses/note_response.dart';
import '../states/edit_note_state.dart';
import 'add_notes_cubit.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  final NotesRepository notesRepository;
  EditNoteCubit(this.notesRepository) : super(EditNotesInitial());

  void editNote(Note note, int id) async {

    emit(EditNotesInitial());
    notesRepository.editNote(note, id);
    emit(EditNotesLoaded());
  }
}