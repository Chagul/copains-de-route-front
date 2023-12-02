import 'dart:async';

import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/model/create_evenement.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class EventFormBloc extends FormBloc<String, String> {
  late CreateEvenement evenement;
  late PolylineResult selectedItinerary;
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

  createCreateEvenement() {
    var roadTypes = _getRoadTypesList();
    var bikeTypes = _getBikeTypesList();
    DateTime eventDateFormated = DateFormat("yyyy-MM-dd hh:mm").parse(
        "${eventDate.value} ${FormatUtils.formatTimeOfDay(eventTime.value)}");
    String eventDateString =
        DateFormat("yyyy-MM-ddThh:mm:ss").format(eventDateFormated);
    evenement = CreateEvenement(
        promoter: 1,
        maxParticipants: eventMaxParticipants.valueToInt!,
        startTime: eventDateString,
        roadType1: roadTypes[0],
        roadType2: roadTypes[1],
        roadType3: roadTypes[2],
        startPoint: selectedItinerary.startAddress!,
        endPoint: selectedItinerary.endAddress!,
        name: eventName.value,
        description: eventDescription.value,
        bikeType1: bikeTypes[0],
        bikeType2: bikeTypes[1],
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
