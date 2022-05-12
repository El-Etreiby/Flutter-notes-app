import 'package:get_it/get_it.dart';

import '../RESTApi/api_client.dart';
import '../models/note.dart';
import '../responses/note_response.dart';

class NotesRepository{ //not a DB!!! for business logic.

  final APIClient apiClient;
  NotesRepository(this.apiClient);

  Future<Note> addNote(Note note){
  return apiClient.addNote(note);
}
  Future<void> editNote(Note note, int id) async{
    await apiClient.updateNote(note, id);
}

Future<List<NoteResponse>> getNotes() async{
    List<NoteResponse> notes = await apiClient.getNotes();
  return notes;
}

  Future<void> deleteNote(NoteResponse note){
    Note toBeSent = Note(title: note.title, content: note.content);
     return apiClient.deleteNote(toBeSent, note.id);
}
}