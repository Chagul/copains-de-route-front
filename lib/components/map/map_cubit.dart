import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/choose_itinerary_widget.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/draw_itinerary.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/pick_itinerary.dart';
import 'package:copains_de_route/components/sub_component_create_itinerary/start_end_widget.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  Set<Polyline> polylines = {};

  late Polyline polylineSelected;

  late PolylineResult routeSelected;

  Marker? markerStart;

  Marker? markerEnd;

  bool markerStartInit = false;

  bool markerEndInit = false;

  bool markerStepsInit = false;

  Set<Marker> steps = {};

  bool alternative = false;

  int selectedWidget = 0;

  bool firstRoute = true;

  int stepIndex = 0;

  Color selectedColor = Colors.blue;
  Color notSelectedColor = Colors.grey;

  List<Widget> widgets = [
    const StartEndWidget(),
    const ChoseItineraryTypeWidget(),
    const DrawItineraryWidget(),
    const PickItineraryWidget(),
  ];

  int selectedIdRoute = 0;

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
    buildPolyline(res);
    emit(MapPolylinesLoaded(res));
  }

  addMarker(LatLng position) {
    if (markerStartInit) {
      markerStart =
          Marker(markerId: const MarkerId("start"), position: position);
    }
    if (markerEndInit) {
      markerEnd = Marker(markerId: const MarkerId("end"), position: position);
    }
    if (markerStepsInit) {
      steps.add(
          Marker(markerId: MarkerId("step$stepIndex"), position: position));
      stepIndex++;
    }
    emit(MapMarkerUpdated());
  }

  startPickStart() {
    markerStartInit = true;
    markerEndInit = false;
    markerStepsInit = false;
  }

  startPickEnd() {
    markerStartInit = false;
    markerEndInit = true;
    markerStepsInit = false;
  }

  clearSteps() {
    steps = {};
    stepIndex = 0;
  }

  changeWidget(SubComponentCreateItineraryPage key) {
    switch (key) {
      case SubComponentCreateItineraryPage.startEndWidget:
        selectedWidget = 0;
      case SubComponentCreateItineraryPage.choseItineraryWidget:
        markerStartInit = false;
        markerEndInit = false;
        alternative = true;
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

  Set<Polyline> buildPolyline(List<PolylineResult> results) {
    polylines = {};
    for (int i = 0; i < results.length; i++) {
      polylines.add(Polyline(
          polylineId: PolylineId(i.toString()),
          color: selectedIdRoute == i || firstRoute
              ? selectedColor
              : notSelectedColor,
          zIndex: selectedIdRoute == i || firstRoute ? 2 : 1,
          width: 5,
          consumeTapEvents: true,
          onTap: () => {
                routeSelected = results[i],
                selectedIdRoute = i,
              },
          points: results[i]
              .points
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList()));
      if (firstRoute) {
        routeSelected = results[0];
        firstRoute = false;
      }
    }
    return polylines;
  }

  addPositionUser(LatLng positionUser) {
    emit(PositionUserLoaded(positionUser));
  }
}
