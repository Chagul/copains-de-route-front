import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

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
}
