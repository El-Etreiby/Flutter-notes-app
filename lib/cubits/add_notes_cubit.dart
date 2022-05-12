import 'dart:async';
import 'package:bloc/bloc.dart';
import '../locator.dart';
import '../models/note.dart';
import '../repositories/note_repo.dart';
import '../responses/note_response.dart';

part '../states/add_notes_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {

  final NotesRepository notesRepository ;

  AddNoteCubit(this.notesRepository) : super(NotesInitial());

  Future<void> addNote(Note note) async {
    try {
      emit(NotesInitial());
     await notesRepository.addNote(note);
      emit(NotesLoaded());

    }
    catch(exception){
    // emit(NotesError());
    }
  }

  Future<List<NoteResponse>?> getNotes() async {
    try {
      return await notesRepository.getNotes();
    }
    catch(exception){
      return null;
    }
  }


}
