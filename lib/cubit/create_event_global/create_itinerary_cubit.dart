import 'package:copains_de_route/cubit/create_event_global/create_itinerary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class CreateItineraryCubit extends Cubit<CreateItineraryState> {
  CreateItineraryCubit() : super(CreateItineraryStateInitial());

  late PolylineResult selectedItinerary;

  addItinerarySelected(PolylineResult itinerary) {
    selectedItinerary = itinerary;
    emit(CreateItineraryRouteValidated());
  }
}
