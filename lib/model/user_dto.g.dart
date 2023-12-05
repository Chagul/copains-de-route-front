// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      login: json['login'] as String,
      numberEventsCreated: json['numberEventsCreated'] as int,
      distanceTraveled: json['distanceTraveled'] as int,
      co2NotEmitted: json['co2NotEmitted'] as int,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'login': instance.login,
      'numberEventsCreated': instance.numberEventsCreated,
      'distanceTraveled': instance.distanceTraveled,
      'co2NotEmitted': instance.co2NotEmitted,
    };
