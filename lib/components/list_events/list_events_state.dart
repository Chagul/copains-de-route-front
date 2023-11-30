import 'package:copains_de_route/model/event_list.dart';

abstract class ListEventState {}

abstract class ListAllEventsState extends ListEventState {}

class ListAllEventsLoadingState extends ListAllEventsState {}

class ListAllEventsLoadedState extends ListAllEventsState {
  final EventList data;
  ListAllEventsLoadedState({required this.data});
}

abstract class ListMyEventsState extends ListEventState {}
