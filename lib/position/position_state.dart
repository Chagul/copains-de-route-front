import 'package:geolocator/geolocator.dart';

abstract class PositionState {}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionSuccess extends PositionState {
  final Position position;

  PositionSuccess({required this.position});
}

class PositionFail extends PositionState {
  final String error;
  PositionFail(this.error);
}
