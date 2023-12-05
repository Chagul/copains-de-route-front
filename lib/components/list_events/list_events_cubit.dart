import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/components/list_events/list_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEventCubit extends Cubit<ListEventState> {
  ListEventCubit(super.initialState);

  getEvents() async {
    emit(ListAllEventsLoadingState());

    var response = CopainsDeRouteApi().getEvents();
    List<Event> eventList;
    EventList data;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              data = EventList(eventList: eventList),
              emit(ListAllEventsLoadedState(data: data)),
            }
          else if (value.statusCode == 204)
            emit(ListAllEventsNoContentState())
        });
  }

  participate(int eventId) async {
    emit(ListAllEventsParticipateLoadingState());

    var response = CopainsDeRouteApi().participateToEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(ListAllEventsParticipateLoadedState())}
          else
            {emit(ListAllEventsParticipateErrorState())}
        });
  }
}
