import 'package:copains_de_route/model/point_custom.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_evenement.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateEvenement {
  String promoter;
  int maxParticipants;
  String startDate;
  String startTime;
  String roadType1;
  String roadType2;
  String roadType3;
  String startAddress;
  String endAddress;
  List<PointCustom> steps;
  String name;
  String description;
  String bikeType1;
  String bikeType2;
  String visibility;
  String route;
  int distance;

  CreateEvenement(
      {required this.promoter,
      required this.maxParticipants,
      required this.startDate,
      required this.startTime,
      required this.roadType1,
      required this.roadType2,
      required this.roadType3,
      required this.startAddress,
      required this.endAddress,
      required this.steps,
      required this.name,
      required this.description,
      required this.bikeType1,
      required this.bikeType2,
      required this.visibility,
      required this.route,
      required this.distance});

  factory CreateEvenement.fromJson(Map<String, dynamic> json) =>
      _$CreateEvenementFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEvenementToJson(this);
}
