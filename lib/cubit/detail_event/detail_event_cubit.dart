import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailEventCubit extends Cubit<DetailEventState> {
  final Event event;
  bool joined = false;
  DetailEventCubit({required this.event}) : super(DetailEventInitialState());

  changeJoined() {
    joined = !joined;
    emit(DetailEventChangedJoinedState());
  }

  participate(int eventId, String login) async {
    emit(DetailEventParticipateLoadingState());

    var response = CopainsDeRouteApi().participateToEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(DetailEventParticipateSucessState())}
          else
            {emit(DetailEventParticipateErrorState())}
        });
  }

  unsubscribe(int eventId, String login) async {
    emit(DetailEventParticipateLoadingState());

    var response = CopainsDeRouteApi().participateToEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(DetailEventParticipateSucessState())}
          else
            {emit(DetailEventParticipateErrorState())}
        });
  }
}
