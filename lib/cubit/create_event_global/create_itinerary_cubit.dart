import 'package:copains_de_route/cubit/create_event_global/create_itinerary_state.dart';
import 'package:copains_de_route/model/point_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateItineraryCubit extends Cubit<CreateItineraryState> {
  CreateItineraryCubit() : super(CreateItineraryStateInitial());

  late PolylineResult selectedItinerary;
  List<PointCustom> steps = [];

  addItinerarySelected(PolylineResult itinerary) {
    selectedItinerary = itinerary;
    emit(CreateItineraryRouteValidated());
  }

  addSteps(Set<Marker> points, Marker markerStart, Marker markerEnd ) {

    steps.add(PointCustom(longitude: markerStart.position.longitude, latitude: markerStart.position.latitude, rank: 0));
    for(int i = 0; i < points.length; i++) {
      steps.add(PointCustom(longitude: points.elementAt(i).position.longitude, latitude: points.elementAt(i).position.latitude, rank: i+1));
    }
    steps.add(PointCustom(longitude: markerEnd.position.longitude, latitude: markerEnd.position.latitude, rank: steps.length));

  }

}
