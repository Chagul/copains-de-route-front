import 'package:copains_de_route/components/create_event/create_event/create_itinerary_state.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class CreateItineraryCubit extends Cubit<CreateItineraryState> {
  CreateItineraryCubit() : super(CreateItineraryStateInitial());

  late PolylineResult selectedItinerary;

  addItinerarySelected(PolylineResult itinerary) {
    selectedItinerary = itinerary;
    emit(CreateItineraryRouteValidated());
  }

  Future<void> postResult() async {
    /*emit(CreateItineraryLoading());
    Dio dio = Dio();

    DateTime eventDate = DateFormat("yyy-MM-dd hh:mm").parse(
        "${eventDateInput.text} ${FormatUtils.formatTimeOfDay(eventTime)}");
    String eventDateString =
        DateFormat("yyyy-MM-dd hh:mm:ss").format(eventDate);
    List<String> roadTypes = _getRoadTypesList();
    List<String> bikeTypes = _getBikeTypesList();
    String visibility = _getVisibilityValue();

    EventFormData data = EventFormData(
        promoter: 0,
        maxParticipants: int.parse(eventNbParticipantsInput.text),
        startTime: eventDateString,
        roadType1: roadTypes[0],
        roadType2: roadTypes[1],
        roadType3: roadTypes[2],
        startPoint: "Lat:0;Lon:0",
        endPoint: "Lat:1;Lon:1",
        name: eventNameInput.text,
        description: eventDescriptionInput.text,
        bikeType1: bikeTypes[0],
        bikeType2: bikeTypes[1],
        visibility: visibility);

    var response = await dio.post("http://localhost:8080/events",
        data: data, options: Options(contentType: Headers.jsonContentType));
    if (response.statusCode == 200) {
      emit(CreateItinerarySuccess());
    } else {
      emit(CreateItineraryFailed(error: response.statusCode!));
    }
  }*/
  }
}
