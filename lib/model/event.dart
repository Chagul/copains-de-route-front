import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String name;
  // final int distance;
  //final String promoter;
  //final int nbParticipants;
  final int maxParticipants;

  Event(
      /*this.distance,*/ /*this.promoter,*/ /*this.nbParticipants,*/
      this.maxParticipants,
      {required this.name});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
