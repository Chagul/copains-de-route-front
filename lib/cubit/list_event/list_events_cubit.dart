import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/format_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEventCubit extends Cubit<ListEventState> {
  EventList dataDisplayed = EventList(eventList: []);
  EventList data = EventList(eventList: []);
  bool sortedByDistance = false;
  bool sortedByParticipants = false;
  bool sortedByDate = false;

  ListEventCubit(super.initialState);

  getEvents() async {
    emit(ListAllEventsLoadingState());

    var response = CopainsDeRouteApi().getEvents();
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              data = EventList(eventList: eventList),
              dataDisplayed = data,
              emit(ListAllEventsLoadedState(data: data)),
            }
          else if (value.statusCode == 204)
            emit(ListAllEventsNoContentState())
        });
  }

  void searchEvents(String lowerCase) {
    emit(ListFilterLoadingState());

    dataDisplayed = EventList(
        eventList: dataDisplayed.eventList
            .where((event) =>
                event.name.toLowerCase().contains(lowerCase.toLowerCase()))
            .toList());
    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByDistance() {
    emit(ListFilterLoadingState());

    if (sortedByDistance) {
      dataDisplayed.eventList.sort((a, b) => b.distance.compareTo(a.distance));
      sortedByDistance = false;
    } else {
      dataDisplayed.eventList.sort((a, b) => a.distance.compareTo(b.distance));
      sortedByDistance = true;
    }
    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByParticipants() {
    emit(ListFilterLoadingState());

    if (sortedByParticipants) {
      dataDisplayed.eventList.sort(
          (a, b) => b.participants.length.compareTo(a.participants.length));
      sortedByParticipants = false;
    } else {
      dataDisplayed.eventList.sort(
          (a, b) => a.participants.length.compareTo(b.participants.length));
      sortedByParticipants = true;
    }
    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByDate() {
    emit(ListFilterLoadingState());

    if (sortedByDate) {
      dataDisplayed.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(b.startDate, b.startTime))
              .compareTo(FormatUtils.formatDateTime(a.startDate, a.startTime)));
      sortedByDate = false;
    } else {
      dataDisplayed.eventList.sort((a, b) =>
          (FormatUtils.formatDateTime(a.startDate, a.startTime))
              .compareTo(FormatUtils.formatDateTime(b.startDate, b.startTime)));
      sortedByDate = true;
    }
    emit(ListFilteredState(data: dataDisplayed));
  }
}
