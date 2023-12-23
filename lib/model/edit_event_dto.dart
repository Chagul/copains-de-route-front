import 'package:copains_de_route/model/point_custom.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_event_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class EditEvenementDto {
  String? promoter;
  int? maxParticipants;
  String? startDate;
  String? startTime;
  String? roadType1;
  String? roadType2;
  String? roadType3;
  String? startAddress;
  String? endAddress;
  List<PointCustom>? steps;
  String? name;
  String? description;
  String? bikeType1;
  String? bikeType2;
  String? visibility;
  String? route;
  double? distance;

  EditEvenementDto(
      {this.promoter,
      this.maxParticipants,
      this.startDate,
      this.startTime,
      this.roadType1,
      this.roadType2,
      this.roadType3,
      this.startAddress,
      this.endAddress,
      this.steps,
      this.name,
      this.description,
      this.bikeType1,
      this.bikeType2,
      this.visibility,
      this.route,
      this.distance});

  factory EditEvenementDto.fromJson(Map<String, dynamic> json) =>
      _$EditEvenementDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EditEvenementDtoToJson(this);
}
