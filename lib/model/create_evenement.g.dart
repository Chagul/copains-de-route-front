// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_evenement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEvenement _$CreateEvenementFromJson(Map<String, dynamic> json) =>
    CreateEvenement(
      maxParticipants: json['maxParticipants'] as int,
      startDate: json['startDate'] as String,
      startTime: json['startTime'] as String,
      roadType1: json['roadType1'] as String?,
      roadType2: json['roadType2'] as String?,
      roadType3: json['roadType3'] as String?,
      startAddress: json['startAddress'] as String,
      endAddress: json['endAddress'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => PointCustom.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      description: json['description'] as String,
      bikeType1: json['bikeType1'] as String?,
      bikeType2: json['bikeType2'] as String?,
      visibility: json['visibility'] as String,
      route: json['route'] as String,
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateEvenementToJson(CreateEvenement instance) {
  final val = <String, dynamic>{
    'maxParticipants': instance.maxParticipants,
    'startDate': instance.startDate,
    'startTime': instance.startTime,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('roadType1', instance.roadType1);
  writeNotNull('roadType2', instance.roadType2);
  writeNotNull('roadType3', instance.roadType3);
  val['startAddress'] = instance.startAddress;
  val['endAddress'] = instance.endAddress;
  val['steps'] = instance.steps.map((e) => e.toJson()).toList();
  val['name'] = instance.name;
  val['description'] = instance.description;
  writeNotNull('bikeType1', instance.bikeType1);
  writeNotNull('bikeType2', instance.bikeType2);
  val['visibility'] = instance.visibility;
  val['route'] = instance.route;
  val['distance'] = instance.distance;
  return val;
}
