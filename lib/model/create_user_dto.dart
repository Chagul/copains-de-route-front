import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDTO {
  final String email;
  final String login;
  final String password;
  final String base64ProfilePic;
  final String profilePicFormat;

  CreateUserDTO(
      {required this.email,
      required this.login,
      required this.password,
      required this.base64ProfilePic,
      required this.profilePicFormat});

  factory CreateUserDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreateUserDTOToJson(this);
}
