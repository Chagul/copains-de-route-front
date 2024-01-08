import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/point_custom.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(includeIfNull: false)
class Event {
  final int id;
  final String name;
  final String description;
  final String promoter;
  final String? promoterProfilePicLocation;
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
      this.promoterProfilePicLocation,
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

  getDateFormated() {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(startDate));
  }

  getRoadTypes() {
    String roadTypes = "";
    if (roadType1 != null) {
      roadTypes = _concatenateStringWithComma(
          roadTypes, _convertRoadTypeEnumToString(roadType1!));
    }
    if (roadType2 != null) {
      roadTypes = _concatenateStringWithComma(
          roadTypes, _convertRoadTypeEnumToString(roadType2!));
    }
    if (roadType3 != null) {
      roadTypes = _concatenateStringWithComma(
          roadTypes, _convertRoadTypeEnumToString(roadType3!));
    }
    return roadTypes;
  }

  getBikeTypes() {
    String bikeTypes = "";
    if (bikeType1 != null) {
      bikeTypes = _concatenateStringWithComma(
          bikeTypes, _convertBikeTypeEnumToString(bikeType1!));
    }
    if (bikeType2 != null) {
      bikeTypes = _concatenateStringWithComma(
          bikeTypes, _convertBikeTypeEnumToString(bikeType2!));
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

  _convertBikeTypeEnumToString(String bikeType) {
    switch (bikeType) {
      case "CITY":
        return "Ville";
      case "ALL_TERRAIN":
        return "Tout terrains";
      case "GRAVEL":
        return "Graviers";
      case "BMX":
        return "BMX";
      default:
        return "Inconnu";
    }
  }

  _convertRoadTypeEnumToString(String roadType) {
    switch (roadType) {
      case "DIRT":
        return "Terre";
      case "ROAD":
        return "Route";
      case "GRAVEL":
        return "Gravier";
      case "CYCLE_PATH":
        return "Piste cyclable";
      case "PAVING_STONE":
        return "Pavés";
      case "OTHERS":
        return "Autres";
      default:
        return "Inconnu";
    }
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  factory Event.clone(Event event) => Event(
      event.id,
      event.name,
      event.description,
      event.promoter,
      event.promoterProfilePicLocation,
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
