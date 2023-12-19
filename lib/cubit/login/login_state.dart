abstract class LoginState {}

class VerifyTokenState extends LoginState {}

class TokenValidState extends LoginState {}

class TokenInvalidState extends LoginState {}

class LoggingInState extends LoginState {}

class LoggedInState extends LoginState {}

class LoginFailedState extends LoginState {}
