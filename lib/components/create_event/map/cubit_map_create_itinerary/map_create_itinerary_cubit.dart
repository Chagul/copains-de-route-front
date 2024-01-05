import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/components/create_event/map/sub_component_create_itinerary_map/pick_itinerary_type_widget.dart';
import 'package:copains_de_route/components/create_event/map/sub_component_create_itinerary_map/add_steps_itinerary.dart';
import 'package:copains_de_route/components/create_event/map/sub_component_create_itinerary_map/pick_recommanded_itinerary.dart';
import 'package:copains_de_route/components/create_event/map/sub_component_create_itinerary_map/pick_start_end_itinerary.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCreateItineraryCubit extends Cubit<MapCreateItineraryState> {
  MapCreateItineraryCubit() : super(MapCreateItineraryStateInitial());

  Set<Polyline> polylines = {};

  List<PolylineResult> polylinesResult = [];
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
    const PickStartEndItinerary(),
    const PickItineraryType(),
    const AddStepsItinerary(),
    const PickRecommandedItinerary(),
  ];

  int selectedIdRoute = 0;

  Future<void> getDirectionsForPoints() async {
    emit(MapPolylinesLoading());
    List<PolylineResult> res = await PolylinePoints().getRouteWithAlternatives(
        request: PolylineRequest(
      apiKey: "{GMP_KEY}",
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
    polylinesResult = res;
    firstRoute = true;
    buildPolyline();
    emit(MapPolylinesLoaded(res));
  }

  addMarker(LatLng position) {
    if (markerStartInit) {
      markerStart = Marker(
          markerId: const MarkerId("start"),
          position: position,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    }
    if (markerEndInit) {
      markerEnd = Marker(
          markerId: const MarkerId("end"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
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
        clearSteps();
        if (markerStart == null || markerEnd == null) {
          emit(DisplayWarning("Le départ ou l'arrivée ne peut pas être vide"));
          break;
        }
        selectedWidget = 1;

      case SubComponentCreateItineraryPage.drawItineraryWidget:
        markerStepsInit = true;
        selectedWidget = 2;
      case SubComponentCreateItineraryPage.pickItineraryWidget:
        markerStepsInit = false;
        selectedWidget = 3;
      default:
        break;
    }

    emit(MapWithWidget(widgets[selectedWidget]));
  }

  buildPolyline() {
    polylines = {};
    for (int i = 0; i < polylinesResult.length; i++) {
      if (firstRoute) {
        routeSelected = polylinesResult[0];
        firstRoute = false;
      }
      polylines.add(Polyline(
          polylineId: PolylineId(i.toString()),
          color: selectedIdRoute == i || firstRoute
              ? selectedColor
              : notSelectedColor,
          zIndex: selectedIdRoute == i || firstRoute ? 2 : 1,
          width: 5,
          consumeTapEvents: true,
          onTap: () => {
                routeSelected = polylinesResult[i],
                selectedIdRoute = i,
                emit(PolylineSelected())
              },
          points: polylinesResult[i]
              .points
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList()));
    }
  }

  addPositionUser(LatLng positionUser) {
    emit(PositionUserLoaded(positionUser));
  }

  clearPolyline() {
    selectedIdRoute = 0;
    polylines = {};
  }
}
