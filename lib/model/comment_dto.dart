import 'package:json_annotation/json_annotation.dart';

part 'comment_dto.g.dart';

@JsonSerializable()
class CommentDTO {
  final int? id;
  final String login;
  final String content;
  final String date;
  int likes;
  bool? isLiked;

  CommentDTO(
      {required this.id,
      required this.login,
      required this.content,
      required this.date,
      required this.likes,
      required this.isLiked});

  factory CommentDTO.fromJson(Map<String, dynamic> json) =>
      _$CommentDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDTOToJson(this);
}
