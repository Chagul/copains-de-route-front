import 'package:copains_de_route/model/friends_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String login;
  final int numberEventsCreated;
  final int numberEventsParticipated;
  final int distanceTraveled;
  final int co2NotEmitted;
  final String? profilePicLocation;
  final List<FriendsDTO> sentFriends;
  final List<FriendsDTO> addedFriends;

  UserDTO(
      {required this.login,
      required this.numberEventsCreated,
      required this.numberEventsParticipated,
      required this.distanceTraveled,
      required this.co2NotEmitted,
      required this.profilePicLocation,
      required this.sentFriends,
      required this.addedFriends});

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
