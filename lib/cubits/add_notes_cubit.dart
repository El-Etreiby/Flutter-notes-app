import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/note.dart';
import '../repositories/note_repo.dart';
import '../responses/note_response.dart';

part '../states/add_notes_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {

  final NotesRepository notesRepository;

  AddNoteCubit(this.notesRepository) : super(NotesInitial());

  Future<void> addNote(Note note) async {
    try {
      print("adding note");
      notesRepository.addNote(note);
      // List<NoteResponse> notesList = await notesRepository.getNotes();
      // List<Note> toBeDisplayed = <Note>[];
      // for(int i = 0; i < notesList.length; i++){
      //   print(notesList.elementAt(i).content);
      //   toBeDisplayed.add(Note(title: notesList.elementAt(i).title,content: notesList.elementAt(i).content));
      // }
      // print(toBeDisplayed);
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
