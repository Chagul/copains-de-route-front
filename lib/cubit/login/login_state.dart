import 'package:copains_de_route/model/user_dto.dart';

abstract class LoginState {
  
}

abstract class UserRefreshState extends LoginState {}

class VerifyTokenState extends LoginState {}

class TokenValidState extends LoginState {}

class TokenInvalidState extends LoginState {}

class LoggingInState extends LoginState {}

class LoggedInState extends LoginState {}

class LoginFailedState extends LoginState {
  final String error;

  LoginFailedState(this.error);
}

class LoginDoesntExistState extends LoginState {}

class RegisteringState extends LoginState {}

class RegisteredState extends LoginState {}

class RegisterFailedState extends LoginState {}

class UserInitialState extends LoginState {}

class UserLoadedState extends LoginState {}

class UserLoadingState extends LoginState {}

class UserLoadedFailed extends LoginState {}

class UserRefreshingState extends UserRefreshState {}

class UserRefreshedState extends UserRefreshState {}

class UserRefreshedFailState extends UserRefreshState {}

 abstract class FriendState extends LoginState {}
class FriendInfoLoadedState extends FriendState {
  final UserDTO friend;
  FriendInfoLoadedState(this.friend);
}

class FriendInfoErrorState extends FriendState {}

class ResetPasswordLinkSentState extends LoginState {}

class ResetPasswordLinkFailedState extends LoginState {}
