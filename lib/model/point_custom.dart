import 'package:json_annotation/json_annotation.dart';

part 'point_custom.g.dart';

@JsonSerializable()
class PointCustom {
  
  double longitude;
  double latitude;
  int rank;


  PointCustom({required this.longitude, required this.latitude, required this.rank});

    factory PointCustom.fromJson(Map<String, dynamic> json) =>
      _$PointCustomFromJson(json);
  Map<String, dynamic> toJson() => _$PointCustomToJson(this);
}