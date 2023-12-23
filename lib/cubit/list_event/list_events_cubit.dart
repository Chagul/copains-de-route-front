import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/sort.dart';
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

  void searchEvents(String search) {
    emit(ListFilterLoadingState());
    if (search.isEmpty || dataDisplayed.eventList.isEmpty) {
      dataDisplayed = data;
    }
    dataDisplayed = EventList(
        eventList: dataDisplayed.eventList
            .where((event) =>
                event.name.toLowerCase().contains(search.toLowerCase()))
            .toList());
    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByDistance() {
    emit(ListFilterLoadingState());

    var (resSortedByDistance, resDataDisplayed) =
        SortUtils().sortByDistance(dataDisplayed, sortedByDistance);

    sortedByDistance = resSortedByDistance;
    dataDisplayed = resDataDisplayed;

    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByParticipants() {
    emit(ListFilterLoadingState());
    var (resSortedByParticipants, resDataDisplayed) =
        SortUtils().sortByParticipants(dataDisplayed, sortedByParticipants);

    sortedByParticipants = resSortedByParticipants;
    dataDisplayed = resDataDisplayed;

    emit(ListFilteredState(data: dataDisplayed));
  }

  void sortEventsByDate() {
    emit(ListFilterLoadingState());
    var (resSortedByDate, resDataDisplayed) =
        SortUtils().sortByDate(dataDisplayed, sortedByDate);

    sortedByDate = resSortedByDate;
    dataDisplayed = resDataDisplayed;

    emit(ListFilteredState(data: dataDisplayed));
  }

  void deletedEvent(int eventId) {
    emit(ListFilterLoadingState());
    dataDisplayed.eventList.removeWhere((element) => element.id == eventId);
    data.eventList.removeWhere((element) => element.id == eventId);
    emit(ListChangedState(data: dataDisplayed));
  }
}
