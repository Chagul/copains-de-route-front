import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/point_custom.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(includeIfNull: false)
class Event {
  final int id;
  final String name;
  final String description;
  final String promoter;
  final int maxParticipants;
  final String startDate;
  final String startTime;
  final String visibility;
  final double distance;
  final String startAddress;
  final String endAddress;
  final String? roadType1;
  final String? roadType2;
  final String? roadType3;
  final String? bikeType1;
  final String? bikeType2;
  final String route;
  final List<CommentDTO> comments;
  final List<UserDTO> participants;
  final List<PointCustom> steps;

  Event(
      this.id,
      this.name,
      this.description,
      this.promoter,
      this.maxParticipants,
      this.startDate,
      this.startTime,
      this.visibility,
      this.distance,
      this.roadType1,
      this.roadType2,
      this.roadType3,
      this.bikeType1,
      this.bikeType2,
      this.comments,
      this.participants,
      this.steps,
      this.route,
      this.startAddress,
      this.endAddress);

  getRoadTypes() {
    String roadTypes = "";
    if (roadType1 != null) {
      roadTypes = _concatenateStringWithComma(roadTypes, roadType1);
    }
    if (roadType2 != null) {
      roadTypes = _concatenateStringWithComma(roadTypes, roadType2);
    }
    if (roadType3 != null) {
      roadTypes = _concatenateStringWithComma(roadTypes, roadType3);
    }
    return roadTypes;
  }

  getBikeTypes() {
    String bikeTypes = "";
    if (bikeType1 != null) {
      bikeTypes = _concatenateStringWithComma(bikeTypes, bikeType1);
    }
    if (bikeType2 != null) {
      bikeTypes = _concatenateStringWithComma(bikeTypes, bikeType2);
    }
    return bikeTypes;
  }

  _concatenateStringWithComma(String base, String? toAdd) {
    if (base.isEmpty) {
      return base + toAdd!;
    } else {
      return "$base, $toAdd";
    }
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  factory Event.clone(Event event) => Event(
      event.id,
      event.name,
      event.description,
      event.promoter,
      event.maxParticipants,
      event.startDate,
      event.startTime,
      event.visibility,
      event.distance,
      event.roadType1,
      event.roadType2,
      event.roadType3,
      event.bikeType1,
      event.bikeType2,
      event.comments,
      event.participants,
      event.steps,
      event.route,
      event.startAddress,
      event.endAddress);
}
