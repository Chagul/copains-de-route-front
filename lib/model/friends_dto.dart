import 'package:json_annotation/json_annotation.dart';

part "friends_dto.g.dart";

@JsonSerializable()
class FriendsDTO {
  final int id;
  final String sender;
  final String added;
  final String? senderProfilePicLocation;
  final String? addedProfilePicLocation;
  final String submissionTime;
  final String? acceptedTime;
  final String status;

  FriendsDTO(
      {required this.id,
      required this.sender,
      required this.added,
      this.senderProfilePicLocation,
      this.addedProfilePicLocation,
      required this.submissionTime,
      required this.acceptedTime,
      required this.status});

  factory FriendsDTO.fromJson(Map<String, dynamic> json) =>
      _$FriendsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsDTOToJson(this);
}
