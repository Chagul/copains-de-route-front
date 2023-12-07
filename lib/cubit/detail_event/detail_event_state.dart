abstract class DetailEventState {}

class DetailEventInitialState extends DetailEventState {
  DetailEventInitialState();
}

class DetailEventChangedJoinedState extends DetailEventState {
  DetailEventChangedJoinedState();
}

class DetailEventParticipateLoadingState extends DetailEventState {}

class DetailEventParticipateSucessState extends DetailEventState {}

class DetailEventParticipateErrorState extends DetailEventState {}
