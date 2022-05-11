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
void editNote(Note note, int id){
    apiClient.updateNote(note, id);
}

Future<List<NoteResponse>> getNotes() async{
    List<NoteResponse> notes = await apiClient.getNotes();
    print("@ repo");
    print(notes.length);
  return notes;
}

Future<String> deleteNote(Note note, int id){
    return apiClient.deleteNote(note, id);
}
}