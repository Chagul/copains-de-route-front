import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/model/create_user_dto.dart';
import 'package:copains_de_route/model/login_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  late String loginField;
  late String passwordField;

  late String registerEmailField;
  late String registerPassswordField;

  verifyToken() async {
    emit(VerifyTokenState());
    var resp = CopainsDeRouteApi().verifyToken();
    resp.then((value) => {
          if (value.statusCode == 200)
            {emit(TokenValidState())}
          else
            {emit(TokenInvalidState())}
        });
  }

  login() async {
    emit(LoggingInState());
    var resp = CopainsDeRouteApi()
        .login(LoginDTO(login: loginField, password: passwordField));
    resp.then((value) => {
          if (value.statusCode == 200)
            {emit(TokenValidState())}
          else
            {emit(LoginFailedState())}
        });
  }

  register() async {
    emit(RegisteringState());
    var resp = CopainsDeRouteApi().register(CreateUserDTO(
        email: registerEmailField,
        login: loginField,
        password: registerPassswordField));
    resp.then((value) => {
          if (value.statusCode == 201)
            {emit(RegisteredState())}
          else
            {emit(RegisterFailedState())}
        });
  }
}
