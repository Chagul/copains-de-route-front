import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDTO {
  final String email;
  final String login;
  final String password;

  CreateUserDTO(
      {required this.email, required this.login, required this.password});

  factory CreateUserDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CreateUserDTOToJson(this);
}
