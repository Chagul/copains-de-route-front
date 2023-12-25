// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_coordinates_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpsCoordinateDto _$GpsCoordinateDtoFromJson(Map<String, dynamic> json) =>
    GpsCoordinateDto(
      northeastLatitude: (json['northeastLatitude'] as num).toDouble(),
      northeastLongitude: (json['northeastLongitude'] as num).toDouble(),
      southwestLatitude: (json['southwestLatitude'] as num).toDouble(),
      southwestLongitude: (json['southwestLongitude'] as num).toDouble(),
      northwestLatitude: (json['northwestLatitude'] as num).toDouble(),
      northwestLongitude: (json['northwestLongitude'] as num).toDouble(),
      southeastLatitude: (json['southeastLatitude'] as num).toDouble(),
      southeastLongitude: (json['southeastLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GpsCoordinateDtoToJson(GpsCoordinateDto instance) =>
    <String, dynamic>{
      'northeastLatitude': instance.northeastLatitude,
      'northeastLongitude': instance.northeastLongitude,
      'southwestLatitude': instance.southwestLatitude,
      'southwestLongitude': instance.southwestLongitude,
      'northwestLatitude': instance.northwestLatitude,
      'northwestLongitude': instance.northwestLongitude,
      'southeastLatitude': instance.southeastLatitude,
      'southeastLongitude': instance.southeastLongitude,
    };
