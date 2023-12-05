import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String login;
  final int numberEventsCreated;
  final int distanceTraveled;
  final int co2NotEmitted;

  UserDTO(
      {required this.login,
      required this.numberEventsCreated,
      required this.distanceTraveled,
      required this.co2NotEmitted});

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
