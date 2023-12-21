import 'package:copains_de_route/model/event_list.dart';

abstract class ListEventState {}

abstract class ListAllEventsState extends ListEventState {}

class ListEventStateInitial extends ListEventState {}

class ListAllEventsLoadingState extends ListAllEventsState {}

class ListAllEventsLoadedState extends ListAllEventsState {
  final EventList data;
  ListAllEventsLoadedState({required this.data});
}

class ListAllEventsNoContentState extends ListAllEventsState {}

class ListAllEventsParticipateLoadingState extends ListAllEventsState {}

class ListAllEventsParticipateLoadedState extends ListAllEventsState {}

class ListAllEventsParticipateErrorState extends ListAllEventsState {}

class ListFilterLoadingState extends ListAllEventsState {}

class ListFilteredState extends ListAllEventsState {
  final EventList data;
  ListFilteredState({required this.data});
}
