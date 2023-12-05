// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_evenement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEvenement _$CreateEvenementFromJson(Map<String, dynamic> json) =>
    CreateEvenement(
      promoter: json['promoter'] as int,
      maxParticipants: json['maxParticipants'] as int,
      startTime: json['startTime'] as String,
      roadType1: json['roadType1'] as String,
      roadType2: json['roadType2'] as String,
      roadType3: json['roadType3'] as String,
      startAddress: json['startAddress'] as String,
      endAddress: json['endAddress'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => PointCustom.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      description: json['description'] as String,
      bikeType1: json['bikeType1'] as String,
      bikeType2: json['bikeType2'] as String,
      visibility: json['visibility'] as String,
      route: json['route'] as String,
    );

Map<String, dynamic> _$CreateEvenementToJson(CreateEvenement instance) =>
    <String, dynamic>{
      'promoter': instance.promoter,
      'maxParticipants': instance.maxParticipants,
      'startTime': instance.startTime,
      'roadType1': instance.roadType1,
      'roadType2': instance.roadType2,
      'roadType3': instance.roadType3,
      'startAddress': instance.startAddress,
      'endAddress': instance.endAddress,
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'description': instance.description,
      'bikeType1': instance.bikeType1,
      'bikeType2': instance.bikeType2,
      'visibility': instance.visibility,
      'route': instance.route,
    };
