abstract class LoginState {}

class VerifyTokenState extends LoginState {}

class TokenValidState extends LoginState {}

class TokenInvalidState extends LoginState {}

class LoggingInState extends LoginState {}

class LoggedInState extends LoginState {}

class LoginFailedState extends LoginState {}

class RegisteringState extends LoginState {}

class RegisteredState extends LoginState {}

class RegisterFailedState extends LoginState {}

class UserInitialState extends LoginState {}

class UserLoadedState extends LoginState {}

class UserLoadingState extends LoginState {}

class UserLoadedFailed extends LoginState {}
