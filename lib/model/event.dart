import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/point_custom.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final int id;
  final String name;
  final String description;
  final String promoter;
  final int maxParticipants;
  final String startDate;
  final String startTime;
  final String visibility;
  final int distance;
  final String startAddress;
  final String endAddress;
  final String roadType1;
  final String roadType2;
  final String roadType3;
  final String bikeType1;
  final String bikeType2;
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
      this.startAddress,
      this.endAddress);

  getRoadTypes() {
    return "$roadType1, $roadType2, $roadType3";
  }

  getBikeTypes() {
    return "$bikeType1, $bikeType2";
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
