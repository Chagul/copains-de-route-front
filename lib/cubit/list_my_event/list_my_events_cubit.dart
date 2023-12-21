import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_my_event/list_my_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMyEventsCubit extends Cubit<ListMyEventsState> {
  EventList myEvents = EventList(eventList: []);
  EventList eventParticipated = EventList(eventList: []);
  bool sortedByDate = false;
  bool sortedByDistance = false;
  bool sortedByParticipants = false;

  ListMyEventsCubit(super.initialState);

  getMyEvents() async {
    emit(ListMyEventsLoadingState());

    var response = CopainsDeRouteApi().getMyEvents();
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              myEvents = EventList(eventList: eventList),
              emit(ListMyEventsLoadedState(data: myEvents)),
            }
          else if (value.statusCode == 204)
            emit(ListMyEventsNoContentState())
        });
  }

  getEventsParticipated() async {
    emit(ListMyEventsLoadingState());
    var response = CopainsDeRouteApi().getEventsParticipated();
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              eventParticipated = EventList(eventList: eventList),
              emit(ListMyEventsLoadedState(data: eventParticipated)),
            }
          else if (value.statusCode == 204)
            emit(ListMyEventsNoContentState())
        });
  }

  void sortEventsByDistance() {
    emit(ListSortingState());

    if (sortedByDistance) {
      myEvents.eventList.sort((a, b) => b.distance.compareTo(a.distance));
      sortedByDistance = false;
    } else {
      myEvents.eventList.sort((a, b) => a.distance.compareTo(b.distance));
      sortedByDistance = true;
    }
    emit(ListSortedState(data: myEvents));
  }

  void sortEventsByParticipants() {
    emit(ListSortingState());

    if (sortedByParticipants) {
      myEvents.eventList.sort(
          (a, b) => b.participants.length.compareTo(a.participants.length));
      sortedByParticipants = false;
    } else {
      myEvents.eventList.sort(
          (a, b) => a.participants.length.compareTo(b.participants.length));
      sortedByParticipants = true;
    }
    emit(ListSortedState(data: myEvents));
  }

  void sortEventsByDate() {
    emit(ListSortingState());

    if (sortedByDate) {
      myEvents.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(b.startDate, b.startTime))
              .compareTo(FormatUtils.formatDateTime(a.startDate, a.startTime)));
      sortedByDate = false;
    } else {
      myEvents.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(a.startDate, a.startTime))
              .compareTo(FormatUtils.formatDateTime(b.startDate, b.startTime)));
      sortedByDate = true;
    }
    emit(ListSortedState(data: myEvents));
  }
}
