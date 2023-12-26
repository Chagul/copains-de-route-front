import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/sort.dart';
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

    var (resSortedByDistance, resDataDisplayed) =
        SortUtils().sortByDistance(eventsJoined, sortedByDistance);

    sortedByDistance = resSortedByDistance;
    eventsJoined = resDataDisplayed;

    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByParticipants() {
    emit(ListSortingState());
    var (resSortedByParticipants, resDataDisplayed) =
        SortUtils().sortByParticipants(eventsJoined, sortedByParticipants);

    sortedByParticipants = resSortedByParticipants;
    eventsJoined = resDataDisplayed;

    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByDate() {
    emit(ListSortingState());
    var (resSortedByDate, resDataDisplayed) =
        SortUtils().sortByDate(eventsJoined, sortedByDate);

    sortedByDate = resSortedByDate;
    eventsJoined = resDataDisplayed;

    emit(ListSortedState(data: eventsJoined));
  }
}
