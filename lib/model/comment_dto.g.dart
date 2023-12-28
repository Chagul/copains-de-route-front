// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDTO _$CommentDTOFromJson(Map<String, dynamic> json) => CommentDTO(
      id: json['id'] as int?,
      login: json['login'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      likes: json['likes'] as int,
      isLiked: json['isLiked'] as bool?,
    );

Map<String, dynamic> _$CommentDTOToJson(CommentDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'content': instance.content,
      'date': instance.date,
      'likes': instance.likes,
      'isLiked': instance.isLiked,
    };
