import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {}

class MapInitial extends MapState {
  
  
}

class MapPolylinesLoaded extends MapState {
  List<PolylineResult> polylines;

  MapPolylinesLoaded(this.polylines);
}

class MapPolylinesLoading extends MapState {}

class MapStartMarkerAdded extends MapState {
  Marker markerStart;

  MapStartMarkerAdded(this.markerStart);
}

class MapEndMarkerAdded extends MapState {
  Marker markerEnd;

  MapEndMarkerAdded(this.markerEnd);
}

class MapStartAndEndMarkerAdded extends MapState{
  Marker markerStart;
  Marker markerEnd;

  MapStartAndEndMarkerAdded(this.markerStart, this.markerEnd);
}

class MapStateError extends MapState{
  String error;

  MapStateError(this.error);
}

class MapWithWidget extends MapState{
  Widget widget;

  MapWithWidget(this.widget);
}

class MapValidated extends MapState {

}

class DisplayWarning extends MapState{
  String warning;

  DisplayWarning(this.warning);
}