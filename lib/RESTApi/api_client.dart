import 'package:notes_with_cubit/responses/note_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart' as http;
import '../models/note.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://localhost:8080/")
abstract class APIClient{ //not a DB!!! for business logic.
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET('/')
  Future<List<NoteResponse>> getNotes();

  @POST('/')
  @http.Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<Note> addNote(@Body() Note note);

  @PUT('note/{id}')
  @http.Headers(<String, dynamic>{
    "Content-Type" : "application/json"
  })
  Future<void> updateNote(@Body() Note note, @Path("id") int id);

  @DELETE('note/{id}')
  Future<String> deleteNote(@Body() Note note, @Path("id") int id);

}