import 'package:json_annotation/json_annotation.dart';

part 'gps_coordinates_dto.g.dart';

@JsonSerializable()
class GpsCoordinateDto {
  final double northeastLatitude;
  final double northeastLongitude;
  final double southwestLatitude;
  final double southwestLongitude;
  final double northwestLatitude;
  final double northwestLongitude;
  final double southeastLatitude;
  final double southeastLongitude;

  GpsCoordinateDto({
    required this.northeastLatitude,
    required this.northeastLongitude,
    required this.southwestLatitude,
    required this.southwestLongitude,
    required this.northwestLatitude,
    required this.northwestLongitude,
    required this.southeastLatitude,
    required this.southeastLongitude,
  });

  factory GpsCoordinateDto.fromJson(Map<String, dynamic> json) =>
      _$GpsCoordinateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GpsCoordinateDtoToJson(this);
}
