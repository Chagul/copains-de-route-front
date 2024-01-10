import 'package:json_annotation/json_annotation.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDTO {
  final String login;
  final String oldPassword;
  final String newPassword;
  final String? base64ProfilePic;
  final String? profilePicFormat;

  UpdateUserDTO(
      {required this.login,
      required this.oldPassword,
      required this.newPassword,
      required this.base64ProfilePic,
      required this.profilePicFormat});

  factory UpdateUserDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserDTOToJson(this);
}
