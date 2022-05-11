// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteResponse _$NoteResponseFromJson(Map<String, dynamic> json) => NoteResponse(
      json['id'] as int,
      json['title'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$NoteResponseToJson(NoteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
