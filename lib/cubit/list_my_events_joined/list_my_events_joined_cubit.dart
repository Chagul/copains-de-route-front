import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMyEventsJoinedCubit extends Cubit<ListMyEventsJoinedState> {
  EventList eventsJoined = EventList(eventList: []);
  bool sortedByDate = false;
  bool sortedByDistance = false;
  bool sortedByParticipants = false;

  ListMyEventsJoinedCubit(super.initialState);

  getEventsParticipated() async {
    emit(ListMyEventsJoinedLoadingState());
    var response = CopainsDeRouteApi().getEventsParticipated();
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              eventsJoined = EventList(eventList: eventList),
              emit(ListMyEventsJoinedLoadedState(data: eventsJoined)),
            }
          else if (value.statusCode == 204)
            emit(ListMyEventsJoinedNoContentState())
        });
  }

  void sortEventsByDistance() {
    emit(ListSortingState());

    if (sortedByDistance) {
      eventsJoined.eventList.sort((a, b) => b.distance.compareTo(a.distance));
      sortedByDistance = false;
    } else {
      eventsJoined.eventList.sort((a, b) => a.distance.compareTo(b.distance));
      sortedByDistance = true;
    }
    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByParticipants() {
    emit(ListSortingState());

    if (sortedByParticipants) {
      eventsJoined.eventList.sort(
          (a, b) => b.participants.length.compareTo(a.participants.length));
      sortedByParticipants = false;
    } else {
      eventsJoined.eventList.sort(
          (a, b) => a.participants.length.compareTo(b.participants.length));
      sortedByParticipants = true;
    }
    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByDate() {
    emit(ListSortingState());

    if (sortedByDate) {
      eventsJoined.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(b.startDate, b.startTime))
              .compareTo(FormatUtils.formatDateTime(a.startDate, a.startTime)));
      sortedByDate = false;
    } else {
      eventsJoined.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(a.startDate, a.startTime))
              .compareTo(FormatUtils.formatDateTime(b.startDate, b.startTime)));
      sortedByDate = true;
    }
    emit(ListSortedState(data: eventsJoined));
  }
}
