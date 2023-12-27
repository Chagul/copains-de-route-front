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

class DetailEventCommentPostedState extends DetailEventState {
  final String comment;
  final String user;
  DetailEventCommentPostedState(this.comment, this.user);
}


class DetailEventCommentErrorState extends DetailEventState {}  
