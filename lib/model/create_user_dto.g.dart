// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserDTO _$CreateUserDTOFromJson(Map<String, dynamic> json) =>
    CreateUserDTO(
      email: json['email'] as String,
      login: json['login'] as String,
      password: json['password'] as String,
      base64ProfilePic: json['base64ProfilePic'] as String?,
      profilePicFormat: json['profilePicFormat'] as String?,
    );

Map<String, dynamic> _$CreateUserDTOToJson(CreateUserDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'login': instance.login,
      'password': instance.password,
      'base64ProfilePic': instance.base64ProfilePic,
      'profilePicFormat': instance.profilePicFormat,
    };
