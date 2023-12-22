// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['promoter'] as String,
      json['maxParticipants'] as int,
      json['startDate'] as String,
      json['startTime'] as String,
      json['visibility'] as String,
      json['distance'] as int,
      json['roadType1'] as String,
      json['roadType2'] as String,
      json['roadType3'] as String,
      json['bikeType1'] as String,
      json['bikeType2'] as String,
      (json['comments'] as List<dynamic>)
          .map((e) => CommentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['participants'] as List<dynamic>)
          .map((e) => UserDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['steps'] as List<dynamic>)
          .map((e) => PointCustom.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['route'] as String,
      json['startAddress'] as String,
      json['endAddress'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'promoter': instance.promoter,
      'maxParticipants': instance.maxParticipants,
      'startDate': instance.startDate,
      'startTime': instance.startTime,
      'visibility': instance.visibility,
      'distance': instance.distance,
      'startAddress': instance.startAddress,
      'endAddress': instance.endAddress,
      'roadType1': instance.roadType1,
      'roadType2': instance.roadType2,
      'roadType3': instance.roadType3,
      'bikeType1': instance.bikeType1,
      'bikeType2': instance.bikeType2,
      'route': instance.route,
      'comments': instance.comments,
      'participants': instance.participants,
      'steps': instance.steps,
    };
