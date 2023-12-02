import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PositionState {}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionSuccess extends PositionState {
  final LatLng latlng;

  PositionSuccess({required this.latlng});
}

class PositionFail extends PositionState {
  final String error;
  PositionFail(this.error);
}
