import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:copains_de_route/model/gps_coordinates_dto.dart';
import 'package:copains_de_route/utils/sort.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListEventCubit extends Cubit<ListEventState> {
  EventList dataDisplayed = EventList(eventList: []);
  EventList data = EventList(eventList: []);
  bool sortedByDistance = false;
  bool sortedByParticipants = false;
  bool sortedByDate = false;
  bool filtered = false;

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
              dataDisplayed = EventList(
                  eventList:
                      data.eventList.map((e) => Event.clone(e)).toList()),
              emit(ListAllEventsLoadedState(data: data)),
            }
          else if (value.statusCode == 204)
            emit(ListAllEventsNoContentState())
        });
  }

  getEventsAround(GoogleMapController controller) async {
    emit(ListEventsAroundLoadingState());

    LatLngBounds bounds = await controller.getVisibleRegion();
    GpsCoordinateDto gpsCoordinates = GpsCoordinateDto(
        northeastLatitude: bounds.northeast.latitude,
        northeastLongitude: bounds.northeast.longitude,
        southwestLatitude: bounds.southwest.latitude,
        southwestLongitude: bounds.southwest.longitude,
        northwestLatitude: bounds.northeast.latitude,
        northwestLongitude: bounds.southwest.longitude,
        southeastLatitude: bounds.southwest.latitude,
        southeastLongitude: bounds.northeast.longitude);
    var response = CopainsDeRouteApi().getEventsAround(gpsCoordinates);
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              data = EventList(eventList: eventList),
              dataDisplayed = EventList(
                  eventList:
                      data.eventList.map((e) => Event.clone(e)).toList()),
              emit(ListAllEventsLoadedState(data: data)),
            }
          else if (value.statusCode == 204)
            emit(ListAllEventsNoContentState())
        });
  }

  void searchEvents(String search) {
    emit(ListFilterLoadingState());
    if (search.isEmpty || dataDisplayed.eventList.isEmpty) {
      dataDisplayed = EventList(
          eventList: data.eventList.map((e) => Event.clone(e)).toList());
    }
    dataDisplayed = EventList(
        eventList: dataDisplayed.eventList
            .where((event) =>
                event.name.toLowerCase().contains(search.toLowerCase()))
            .toList());
    emit(ListSortedState(data: dataDisplayed));
  }

  void sortEventsByDistance() {
    emit(ListFilterLoadingState());

    var (resSortedByDistance, resDataDisplayed) =
        SortUtils().sortByDistance(dataDisplayed, sortedByDistance);

    sortedByDistance = resSortedByDistance;
    if (sortedByDistance) {
      sortedByDate = false;
      sortedByParticipants = false;
    }
    dataDisplayed = resDataDisplayed;

    emit(ListSortedState(data: dataDisplayed));
  }

  void sortEventsByParticipants() {
    emit(ListFilterLoadingState());
    var (resSortedByParticipants, resDataDisplayed) =
        SortUtils().sortByParticipants(dataDisplayed, sortedByParticipants);

    sortedByParticipants = resSortedByParticipants;
    if (sortedByParticipants) {
      sortedByDate = false;
      sortedByDistance = false;
    }
    dataDisplayed = resDataDisplayed;

    emit(ListSortedState(data: dataDisplayed));
  }

  void sortEventsByDate() {
    emit(ListFilterLoadingState());
    var (resSortedByDate, resDataDisplayed) =
        SortUtils().sortByDate(dataDisplayed, sortedByDate);

    sortedByDate = resSortedByDate;
    if (sortedByDate) {
      sortedByDistance = false;
      sortedByParticipants = false;
    }
    dataDisplayed = resDataDisplayed;

    emit(ListSortedState(data: dataDisplayed));
  }

  void deletedEvent(int eventId) {
    emit(ListFilterLoadingState());
    dataDisplayed.eventList.removeWhere((element) => element.id == eventId);
    data.eventList.removeWhere((element) => element.id == eventId);
    emit(ListChangedState(data: dataDisplayed));
  }

  void filterEvents(filterDtos) {
    var response = CopainsDeRouteApi().filterEvent(filterDtos);
    List<Event> eventList;
    response.then((value) => {
          if (value.statusCode == 200)
            {
              eventList = (value.data as List)
                  .map((item) => Event.fromJson(item))
                  .toList(),
              dataDisplayed = EventList(eventList: eventList),
              emit(ListAllEventsLoadedState(data: data)),
            }
          else if (value.statusCode == 204)
            emit(ListAllEventsNoContentState())
        });
    filtered = true;
    emit(ListFilteredState(data: dataDisplayed));
  }

  void resetFilter() {
    filtered = false;
    dataDisplayed = EventList(
        eventList: data.eventList.map((e) => Event.clone(e)).toList());
    emit(ListChangedState(data: dataDisplayed));
  }
}
