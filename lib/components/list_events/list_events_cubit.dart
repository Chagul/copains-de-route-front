import 'package:copains_de_route/components/list_events/list_events_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/event_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListEventCubit extends Cubit<ListEventState> {
  ListEventCubit(super.initialState);

  getEvents() async {
    emit(ListAllEventsLoadingState());

    Dio dio = Dio();

    var response = await dio.get(
      "https://app-o5ei237sga-ew.a.run.app/events",
    );

    if (response.statusCode == 200) {
      List<Event> eventList =
          (response.data as List).map((item) => Event.fromJson(item)).toList();
      EventList data = EventList(eventList: eventList);

      emit(ListAllEventsLoadedState(data: data));
    }

    if (response.statusCode == 204) {
      emit(ListAllEventsNoContentState());
    }
  }
}
