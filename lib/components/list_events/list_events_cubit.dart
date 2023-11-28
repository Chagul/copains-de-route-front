import 'package:copains_de_route/components/list_events/list_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEventCubit extends Cubit<ListEventState> {
  ListEventCubit(super.initialState);

  getEvents() async {
    emit(ListAllEventsLoadedState(data: null));
  }
}
