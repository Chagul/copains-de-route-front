import 'package:copains_de_route/model/event_list.dart';

abstract class ListMyEventsJoinedState {}

class ListMyEventsJoinedStateInitial extends ListMyEventsJoinedState {}

class ListMyEventsJoinedLoadingState extends ListMyEventsJoinedState {}

class ListMyEventsJoinedLoadedState extends ListMyEventsJoinedState {
  final EventList data;
  ListMyEventsJoinedLoadedState({required this.data});
}

class ListMyEventsJoinedNoContentState extends ListMyEventsJoinedState {}

class ListSortingState extends ListMyEventsJoinedState {}

class ListSortedState extends ListMyEventsJoinedState {
  final EventList data;
  ListSortedState({required this.data});
}
