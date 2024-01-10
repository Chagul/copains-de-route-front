// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDTO _$UpdateUserDTOFromJson(Map<String, dynamic> json) =>
    UpdateUserDTO(
      login: json['login'] as String,
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
      base64ProfilePic: json['base64ProfilePic'] as String,
      profilePicFormat: json['profilePicFormat'] as String,
    );

Map<String, dynamic> _$UpdateUserDTOToJson(UpdateUserDTO instance) =>
    <String, dynamic>{
      'login': instance.login,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'base64ProfilePic': instance.base64ProfilePic,
      'profilePicFormat': instance.profilePicFormat,
    };
