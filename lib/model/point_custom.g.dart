// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_custom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointCustom _$PointCustomFromJson(Map<String, dynamic> json) => PointCustom(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      rank: json['rank'] as int,
    );

Map<String, dynamic> _$PointCustomToJson(PointCustom instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'rank': instance.rank,
    };
