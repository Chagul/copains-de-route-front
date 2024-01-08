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

    var (resSortedByDistance, resmyEvents) =
        SortUtils().sortByDistance(eventsJoined, sortedByDistance);

    sortedByDistance = resSortedByDistance;
    sortedByDate = !sortedByDistance;
    sortedByParticipants = !sortedByDistance;
    eventsJoined = resmyEvents;

    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByParticipants() {
    emit(ListSortingState());
    var (resSortedByParticipants, resmyEvents) =
        SortUtils().sortByParticipants(eventsJoined, sortedByParticipants);

    sortedByParticipants = resSortedByParticipants;
    sortedByDate = !sortedByParticipants;
    sortedByDistance = !sortedByParticipants;
    eventsJoined = resmyEvents;

    emit(ListSortedState(data: eventsJoined));
  }

  void sortEventsByDate() {
    emit(ListSortingState());
    var (resSortedByDate, resmyEvents) =
        SortUtils().sortByDate(eventsJoined, sortedByDate);

    sortedByDate = resSortedByDate;
    sortedByParticipants = !sortedByDate;
    sortedByDistance = !sortedByDate;
    eventsJoined = resmyEvents;

    emit(ListSortedState(data: eventsJoined));
  }
}
