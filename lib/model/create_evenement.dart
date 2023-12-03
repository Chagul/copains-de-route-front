import 'package:json_annotation/json_annotation.dart';
part 'create_evenement.g.dart';

@JsonSerializable()
class CreateEvenement {
  int promoter;
  int maxParticipants;
  String startTime;
  String roadType1;
  String roadType2;
  String roadType3;
  String startPoint;
  String endPoint;
  String name;
  String description;
  String bikeType1;
  String bikeType2;
  String visibility;

  CreateEvenement({
    required this.promoter,
    required this.maxParticipants,
    required this.startTime,
    required this.roadType1,
    required this.roadType2,
    required this.roadType3,
    required this.startPoint,
    required this.endPoint,
    required this.name,
    required this.description,
    required this.bikeType1,
    required this.bikeType2,
    required this.visibility,
  });

  factory CreateEvenement.fromJson(Map<String, dynamic> json) =>
      _$CreateEvenementFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEvenementToJson(this);
}
