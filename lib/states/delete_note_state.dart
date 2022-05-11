import '../models/note.dart';

abstract class DeleteNoteState {

}

class DeleteNotesInitial extends DeleteNoteState {

}
class DeleteNotesLoaded extends DeleteNoteState {
  final List<Note> loadedNotes;
  DeleteNotesLoaded(this.loadedNotes);
}
