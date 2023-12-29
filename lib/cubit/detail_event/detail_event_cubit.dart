import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/model/comment_dto.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailEventCubit extends Cubit<DetailEventState> {
  final Event event;
  bool joined = false;
  DetailEventCubit({required this.event}) : super(DetailEventInitialState());

  participate(int eventId, UserDTO user) async {
    emit(DetailEventParticipateLoadingState());
    var response = CopainsDeRouteApi().participateToEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {
              event.participants.add(user),
              joined = true,
              emit(DetailEventParticipateSucessState())
            }
          else
            {emit(DetailEventParticipateErrorState())}
        });
  }

  unsubscribe(int eventId, UserDTO user) async {
    emit(DetailEventParticipateLoadingState());

    var response = CopainsDeRouteApi().unsubscribeToEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {
              event.participants.removeWhere(
                  (participant) => participant.login == user.login),
              joined = false,
              emit(DetailEventParticipateSucessState())
            }
          else
            {emit(DetailEventParticipateErrorState())}
        });
  }

  void deleteEvent(int eventId) {
    emit(DetailEventParticipateLoadingState());

    var response = CopainsDeRouteApi().deleteEvent(eventId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(DetailEventParticipateSucessState())}
          else
            {emit(DetailEventParticipateErrorState())}
        });
  }

  void updateJoined(UserDTO user) {
    joined = event.participants
        .any((participant) => participant.login == user.login);
  }


void postComment(String comment, String login, int eventId) async {
  var response = await CopainsDeRouteApi().postComment(comment, login, eventId);
  int idComment = 0;
  if (response.statusCode == 201) {
    idComment = response.data;
    emit(DetailEventCommentPostedState(comment, login, idComment));
  } else {
    emit(DetailEventCommentErrorState());
  }
}

  void addCommentToEvent (int id, String content, String login) {
    event.comments.add(CommentDTO(
      id: id,
      content: content,
      login: login,
      date: DateTime.now().toString(),
      likes: 0,
      isLiked: false,
    ));
    emit(DetailEventCommentSucessState(event.comments));
  }

  void likeComment(int commentId, int likes) {
    var response = CopainsDeRouteApi().likeComment(commentId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(DetailEventLikedCommentState(commentId, likes + 1))}
          else
            {emit(DetailEventCommentErrorState())}
        });
  }

  void dislikeComment(int commentId, int likes) {
    var response = CopainsDeRouteApi().dislikeComment(commentId);
    response.then((value) => {
          if (value.statusCode == 200)
            {emit(DetailEventDislikeCommentState(commentId, likes - 1))}
          else
            {emit(DetailEventCommentErrorState())}
        });
  }
}