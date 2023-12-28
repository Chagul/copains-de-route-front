import 'package:json_annotation/json_annotation.dart';

part 'filter_evenement.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FilterEvenement {
  int distanceMin;
  int distanceMax;
  String startDate;
  String endDate;
  List<String> roadTypes;
  List<String> bikeTypes;
  List<String> visibility;

  FilterEvenement(this.distanceMin, this.distanceMax, this.startDate,
      this.endDate, this.roadTypes, this.bikeTypes, this.visibility);

  factory FilterEvenement.fromJson(Map<String, dynamic> json) =>
      _$FilterEvenementFromJson(json);
  Map<String, dynamic> toJson() => _$FilterEvenementToJson(this);
}
