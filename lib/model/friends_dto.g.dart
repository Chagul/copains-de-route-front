// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendsDTO _$FriendsDTOFromJson(Map<String, dynamic> json) => FriendsDTO(
      id: json['id'] as int,
      sender: json['sender'] as String,
      added: json['added'] as String,
      submissionTime: json['submissionTime'] as String,
      acceptedTime: json['acceptedTime'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$FriendsDTOToJson(FriendsDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'added': instance.added,
      'submissionTime': instance.submissionTime,
      'acceptedTime': instance.acceptedTime,
      'status': instance.status,
    };
