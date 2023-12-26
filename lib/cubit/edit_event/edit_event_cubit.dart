import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/edit_event/edit_event_state.dart';
import 'package:copains_de_route/model/edit_event_dto.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditEventCubit extends Cubit<EditEventState> {
  Event event;
  EditEventCubit({required this.event}) : super(EditEventInitialState());

  void editEvent(Event event) {
    emit(EditEventLoadingState());
    var editEventDto = EditEvenementDto(
        bikeType1: event.bikeType1,
        bikeType2: event.bikeType2,
        description: event.description,
        distance: event.distance,
        endAddress: event.endAddress,
        maxParticipants: event.maxParticipants,
        name: event.name,
        promoter: event.promoter,
        roadType1: event.roadType1,
        roadType2: event.roadType2,
        roadType3: event.roadType3,
        route: event.route,
        startDate: event.startDate,
        startTime: event.startTime,
        startAddress: event.startAddress,
        visibility: event.visibility);
    var response = CopainsDeRouteApi().editEvent(editEventDto, event.id);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(EditEventSuccessState())}
          else
            {emit(EditEventErrorState())}
        });
  }
}
