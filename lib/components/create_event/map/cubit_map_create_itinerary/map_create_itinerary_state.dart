import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapCreateItineraryState {}

class MapCreateItineraryStateInitial extends MapCreateItineraryState {}

class MapPolylinesLoaded extends MapCreateItineraryState {
  List<PolylineResult> polylines;

  MapPolylinesLoaded(this.polylines);
}

class MapPolylinesLoading extends MapCreateItineraryState {}

class MapStartMarkerAdded extends MapCreateItineraryState {
  Marker markerStart;

  MapStartMarkerAdded(this.markerStart);
}

class MapEndMarkerAdded extends MapCreateItineraryState {
  Marker markerEnd;

  MapEndMarkerAdded(this.markerEnd);
}

class MapStartAndEndMarkerAdded extends MapCreateItineraryState {
  Marker markerStart;
  Marker markerEnd;

  MapStartAndEndMarkerAdded(this.markerStart, this.markerEnd);
}

class MapCreateItineraryStateError extends MapCreateItineraryState {
  String error;

  MapCreateItineraryStateError(this.error);
}

class MapWithWidget extends MapCreateItineraryState {
  Widget widget;

  MapWithWidget(this.widget);
}

class MapValidated extends MapCreateItineraryState {}

class DisplayWarning extends MapCreateItineraryState {
  String warning;

  DisplayWarning(this.warning);
}

class PositionUserLoaded extends MapCreateItineraryState {
  LatLng positionUser;
  PositionUserLoaded(this.positionUser);
}

class MapMarkerUpdated extends MapCreateItineraryState {}

class PolylineSelected extends MapCreateItineraryState {}
