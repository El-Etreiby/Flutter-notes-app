import 'package:json_annotation/json_annotation.dart';
import '../models/note.dart';
part 'note_response.g.dart';

@JsonSerializable()
class NoteResponse {

  final int id;
  final String title;
  final String content;

  NoteResponse(this.id, this.title, this.content);

  factory NoteResponse.fromJson(Map<String, dynamic> json) =>
      _$NoteResponseFromJson(json);
}