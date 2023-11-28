import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/choose_itinerary_widget.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/start_end_widget.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  late List<Polyline> polylines;

  late Polyline polylineSelected;

  Marker? markerStart;

  Marker? markerEnd;

  late List<Marker> steps;

  bool alternative = false;

  int selectedWidget = 0;

  List<Widget> widgets = [
    const StartEndWidget(),
    const ChoseItineraryTypeWidget(),
    //DrawItineraryWidget(),
    //PickItineraryWidget(),
  ];

  Future<void> getDirectionsForPoints() async {
    if (markerStart == null || markerEnd == null) {
      emit(MapStateError("start or end null"));
      return;
    }
    List<PolylineResult> res = await PolylinePoints().getRouteWithAlternatives(
        request: PolylineRequest(
      apiKey: "{API.KEY}",
      origin: PointLatLng(
          markerStart!.position.latitude, markerStart!.position.longitude),
      destination: PointLatLng(
          markerEnd!.position.latitude, markerEnd!.position.longitude),
      alternatives: alternative,
      avoidFerries: true,
      avoidHighways: true,
      avoidTolls: true,
      mode: TravelMode.bicycling,
      wayPoints: steps
          .map((s) => PolylineWayPoint(
              location: "${s.position.latitude},${s.position.longitude}"))
          .toList(),
      optimizeWaypoints: false,
    ));
    emit(MapPolylinesLoaded(res));
  }

  addMarkerStart(LatLng position) {}

  addMarkerEnd(LatLng position) {}

  startPickStart() {
    print("pickstart");
  }

  startPickEnd() {
    print("pickend");
  }

  changeWidget(SubComponentCreateItineraryPage key) {
    switch (key) {
      case SubComponentCreateItineraryPage.startEndWidget:
        selectedWidget = 0;
      case SubComponentCreateItineraryPage.choseItineraryWidget:
        selectedWidget = 1;
        if (markerStart == null || markerEnd == null) {
          emit(DisplayWarning("Start or end can't be empty"));
        }
      case SubComponentCreateItineraryPage.drawItineraryWidget:
        selectedWidget = 2;
      case SubComponentCreateItineraryPage.pickItineraryWidget:
        selectedWidget = 3;
      default:
        break;
    }

    emit(MapWithWidget(widgets[selectedWidget]));
  }
}
