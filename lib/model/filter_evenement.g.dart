// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_evenement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEvenement _$FilterEvenementFromJson(Map<String, dynamic> json) =>
    FilterEvenement(
      json['distanceMin'] as int,
      json['distanceMax'] as int,
      json['startDate'] as String,
      json['endDate'] as String,
      (json['roadTypes'] as List<dynamic>).map((e) => e as String).toList(),
      (json['bikeTypes'] as List<dynamic>).map((e) => e as String).toList(),
      (json['visibility'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FilterEvenementToJson(FilterEvenement instance) =>
    <String, dynamic>{
      'distanceMin': instance.distanceMin,
      'distanceMax': instance.distanceMax,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'roadTypes': instance.roadTypes,
      'bikeTypes': instance.bikeTypes,
      'visibility': instance.visibility,
    };
