// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      login: json['login'] as String,
      numberEventsCreated: json['numberEventsCreated'] as int,
      numberEventsParticipated: json['numberEventsParticipated'] as int,
      distanceTraveled: json['distanceTraveled'] as int,
      co2NotEmitted: json['co2NotEmitted'] as int,
      profilePicLocation: json['profilePicLocation'] as String?,
      sentFriends: (json['sentFriends'] as List<dynamic>)
          .map((e) => FriendsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      addedFriends: (json['addedFriends'] as List<dynamic>)
          .map((e) => FriendsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'login': instance.login,
      'numberEventsCreated': instance.numberEventsCreated,
      'numberEventsParticipated': instance.numberEventsParticipated,
      'distanceTraveled': instance.distanceTraveled,
      'co2NotEmitted': instance.co2NotEmitted,
      'profilePicLocation': instance.profilePicLocation,
      'sentFriends': instance.sentFriends,
      'addedFriends': instance.addedFriends,
    };
