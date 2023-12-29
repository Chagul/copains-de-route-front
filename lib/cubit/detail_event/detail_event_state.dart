import 'package:copains_de_route/model/comment_dto.dart';

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

class CommentUsernameFetchedState extends DetailEventState {
  final String username;

  CommentUsernameFetchedState(this.username);
}

class CommentUsernameErrorState extends DetailEventState {}

class DetailEventCommentPostedState extends DetailEventState {
  final String comment;
  final String user;
  final int idComment;
  DetailEventCommentPostedState(this.comment, this.user, this.idComment);
}

class DetailEventCommentSucessState extends DetailEventState {
  final List<CommentDTO> comments;
  DetailEventCommentSucessState(this.comments);
}

class DetailEventCommentErrorState extends DetailEventState {}

class DetailEventLikedCommentState extends DetailEventState {
  final int commentId;
  final int likes;
  DetailEventLikedCommentState(this.commentId, this.likes);
}

class DetailEventDislikeCommentState extends DetailEventState {
  final int commentId;
  final int likes;
  DetailEventDislikeCommentState(this.commentId, this.likes);
}
