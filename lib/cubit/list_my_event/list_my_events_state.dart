import 'package:copains_de_route/model/event_list.dart';

abstract class ListMyEventsState {}

class ListMyEventsStateInitial extends ListMyEventsState {}

class ListMyEventsLoadingState extends ListMyEventsState {}

class ListMyEventsLoadedState extends ListMyEventsState {
  final EventList data;
  ListMyEventsLoadedState({required this.data});
}

class ListMyEventsNoContentState extends ListMyEventsState {}

class ListSortingState extends ListMyEventsState {}

class ListSortedState extends ListMyEventsState {
  final EventList data;
  ListSortedState({required this.data});
}
