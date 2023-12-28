import 'dart:async';

import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/model/create_evenement.dart';
import 'package:copains_de_route/model/point_custom.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class EventFormBloc extends FormBloc<String, String> {
  late CreateEvenement evenement;
  late PolylineResult selectedItinerary;
  late List<PointCustom> steps = [];
  final eventName = TextFieldBloc();
  final eventDate =
      InputFieldBloc<DateTime?, Object>(initialValue: DateTime.now());
  final eventTime =
      InputFieldBloc<TimeOfDay?, Object>(initialValue: TimeOfDay.now());
  final eventDescription = TextFieldBloc();
  final eventMaxParticipants = TextFieldBloc();
  final eventIsPublic = BooleanFieldBloc();

  // Road Types
  final eventIsPathCyclePath = BooleanFieldBloc();
  final eventIsPathGravel = BooleanFieldBloc();
  final eventIsPathPavingStones = BooleanFieldBloc();
  final eventIsPathDirt = BooleanFieldBloc();
  final eventIsPathRoad = BooleanFieldBloc();
  final eventIsPathOthers = BooleanFieldBloc();

  // Bike Types
  final eventIsBikeAllTerrain = BooleanFieldBloc();
  final eventIsBikeGravel = BooleanFieldBloc();
  final eventIsBikeCity = BooleanFieldBloc();
  final eventIsBikeBMX = BooleanFieldBloc();

  EventFormBloc() : super(autoValidate: false) {
    addFieldBlocs(fieldBlocs: [
      eventName,
      eventDate,
      eventTime,
      eventDescription,
      eventMaxParticipants,
      eventIsPublic,
      eventIsPathCyclePath,
      eventIsPathGravel,
      eventIsPathPavingStones,
      eventIsPathDirt,
      eventIsPathRoad,
      eventIsPathOthers,
      eventIsBikeAllTerrain,
      eventIsBikeGravel,
      eventIsBikeCity,
      eventIsBikeBMX,
    ]);
  }

  addItinerary(PolylineResult itinerary) {
    selectedItinerary = itinerary;
  }

  addSteps(List<PointCustom> points) {
    for (int i = 0; i < points.length; i++) {
      steps.add(PointCustom(
          longitude: points[i].longitude,
          latitude: points[i].latitude,
          rank: steps.length));
    }
  }

  createCreateEvenement() {
    var roadTypes = _getRoadTypesList();
    var bikeTypes = _getBikeTypesList();

    evenement = CreateEvenement(
        maxParticipants: eventMaxParticipants.valueToInt!,
        startDate: DateFormat("yyyy-MM-dd").format(eventDate.value!).toString(),
        startTime: FormatUtils.formatTimeOfDay(eventTime.value!),
        roadType1: roadTypes.isNotEmpty ? roadTypes[0] : null,
        roadType2: roadTypes.length >= 2 ? roadTypes[1] : null,
        roadType3: roadTypes.length >= 3 ? roadTypes[2] : null,
        startAddress: selectedItinerary.startAddress!,
        endAddress: selectedItinerary.endAddress!,
        steps: steps,
        route: selectedItinerary.overviewPolyline!,
        name: eventName.value,
        description: eventDescription.value,
        distance: double.parse(selectedItinerary.distance!.split(' ')[0]),
        bikeType1: bikeTypes.isNotEmpty ? bikeTypes[0] : null,
        bikeType2: bikeTypes.length >= 2 ? bikeTypes[1] : null,
        visibility: eventIsPublic.value ? "PUBLIC" : "PRIVATE");
  }

  @override
  FutureOr<void> onSubmitting() {
    emitLoading();
    createCreateEvenement();
    var resp = CopainsDeRouteApi().postItinerary(evenement);
    resp.then((value) => {
          if (value.statusCode == 201)
            {emitSuccess()}
          else
            {emitFailure(failureResponse: value.statusMessage)}
        });
  }

  List<String> _getRoadTypesList() {
    List<String> roadTypesList = [];
    if (eventIsPathDirt.value) {
      roadTypesList.add('DIRT');
    }
    if (eventIsPathRoad.value) {
      roadTypesList.add('ROAD');
    }
    if (eventIsPathGravel.value) {
      roadTypesList.add('GRAVEL');
    }
    if (eventIsPathCyclePath.value) {
      roadTypesList.add('CYCLE_PATH');
    }
    if (eventIsPathPavingStones.value) {
      roadTypesList.add('PAVING_STONE');
    }
    if (eventIsPathOthers.value) {
      roadTypesList.add('OTHERS');
    }
    return roadTypesList;
  }

  List<String> _getBikeTypesList() {
    List<String> bikeTypes = [];
    if (eventIsBikeCity.value) {
      bikeTypes.add('CITY');
    }
    if (eventIsBikeAllTerrain.value) {
      bikeTypes.add('ALL_TERRAIN');
    }
    if (eventIsBikeGravel.value) {
      bikeTypes.add('GRAVEL');
    }
    if (eventIsBikeBMX.value) {
      bikeTypes.add('BMX');
    }
    return bikeTypes;
  }
}
