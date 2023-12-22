// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDTO _$CommentDTOFromJson(Map<String, dynamic> json) => CommentDTO(
      login: json['login'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$CommentDTOToJson(CommentDTO instance) =>
    <String, dynamic>{
      'login': instance.login,
      'content': instance.content,
      'date': instance.date,
      'likes': instance.likes,
    };
