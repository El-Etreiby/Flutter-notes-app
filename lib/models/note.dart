import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
part 'note.g.dart';

@JsonSerializable()
class Note {
  String title;
  String content;

  Note({required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

}