import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_my_event/list_my_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/utils/sort.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMyEventsCubit extends Cubit<ListMyEventsState> {
  EventList myEvents = EventList(eventList: []);
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
              myEvents = EventList(eventList: eventList),
              emit(ListMyEventsLoadedState(data: myEvents)),
            }
          else if (value.statusCode == 204)
            emit(ListMyEventsNoContentState())
        });
  }

  void sortEventsByDistance() {
    emit(ListSortingState());

    var (resSortedByDistance, resDataDisplayed) =
        SortUtils().sortByDistance(myEvents, sortedByDistance);

    sortedByDistance = resSortedByDistance;
    myEvents = resDataDisplayed;

    emit(ListSortedState(data: myEvents));
  }

  void sortEventsByParticipants() {
    emit(ListSortingState());
    var (resSortedByParticipants, resDataDisplayed) =
        SortUtils().sortByParticipants(myEvents, sortedByParticipants);

    sortedByParticipants = resSortedByParticipants;
    myEvents = resDataDisplayed;

    emit(ListSortedState(data: myEvents));
  }

  void sortEventsByDate() {
    emit(ListSortingState());
    var (resSortedByDate, resDataDisplayed) =
        SortUtils().sortByDate(myEvents, sortedByDate);

    sortedByDate = resSortedByDate;
    myEvents = resDataDisplayed;

    emit(ListSortedState(data: myEvents));
  }
}
