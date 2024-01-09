abstract class AddFriendState {}

class AddFriendInitialState extends AddFriendState {}

class AddFriendFailedState extends AddFriendState {}

class AddFriendSucceedState extends AddFriendState {}

class FriendRequestAlreadyExistsState extends AddFriendState {}

class FriendRequestCannotAddItSelfState extends AddFriendState {}

class AcceptFriendSucceedState extends AddFriendState {}

class AcceptFriendFailedState extends AddFriendState {}

class AcceptOrDenyFriendFailedState extends AddFriendState {}

class DenyFriendSucceedState extends AddFriendState {}

class DenyFriendFailedState extends AddFriendState {}

class DeleteFriendSucceedState extends AddFriendState {}

class DeleteFriendFailedState extends AddFriendState {}
