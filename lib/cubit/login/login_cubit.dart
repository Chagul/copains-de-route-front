import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/model/create_user_dto.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/model/login_dto.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  late String loginField;
  late String passwordField;

  late String registerEmailField;
  late String registerPassswordField;

  String? base64ProfilePic;
  String? profilePicFormat;

  late UserDTO user;
  late List<FriendsDTO> acceptedFriends;
  late List<FriendsDTO> pendingRequests;

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
          else if (value.statusCode == 400)
            {emit(LoginFailedState("Une erreur est survenue"))}
          else if (value.statusCode == 401)
            {emit(LoginFailedState("Mauvaise combinaison Login/Password"))}
          else if (value.statusCode == 404)
            {emit(LoginFailedState("L'utilisateur n'existe pas"))}
        });
  }

  register() async {
    emit(RegisteringState());
    var resp = CopainsDeRouteApi().register(CreateUserDTO(
        email: registerEmailField,
        login: loginField,
        password: registerPassswordField,
        base64ProfilePic: base64ProfilePic,
        profilePicFormat: profilePicFormat));
    resp.then((value) => {
          if (value.statusCode == 201)
            {emit(RegisteredState())}
          else
            {emit(RegisterFailedState())}
        });
  }

  void getUser() async {
    emit(UserLoadingState());
    var resp = CopainsDeRouteApi().getUser();
    resp.then((value) => {
          if (value.statusCode == 200)
            {
              user = UserDTO.fromJson(value.data),
              acceptedFriends = user.sentFriends
                      .where((f) => f.status == "ACCEPTED")
                      .toList() +
                  user.addedFriends
                      .where((f) => f.status == "ACCEPTED")
                      .toList(),
              pendingRequests =
                  user.addedFriends.where((f) => f.status == "SENT").toList(),
              emit(UserLoadedState())
            }
          else
            {emit(UserLoadedFailed())}
        });
  }

  Future<void> refreshUser() async {
    emit(UserRefreshingState());
    var resp = CopainsDeRouteApi().getUser();
    resp.then((value) => {
          if (value.statusCode == 200)
            {
              user = UserDTO.fromJson(value.data),
              acceptedFriends = user.sentFriends
                      .where((f) => f.status == "ACCEPTED")
                      .toList() +
                  user.addedFriends
                      .where((f) => f.status == "ACCEPTED")
                      .toList(),
              pendingRequests =
                  user.addedFriends.where((f) => f.status == "SENT").toList(),
              emit(UserRefreshedState())
            }
          else
            {emit(UserRefreshedFailState())}
        });
  }

  void sendResetPasswordLink(String email) {
    var resp = CopainsDeRouteApi().sendResetPasswordLink(email);
    resp.then((value) => {
          if (value.statusCode == 200)
            {emit(ResetPasswordLinkSentState())}
          else if (value.statusCode == 404)
            {emit(ResetPasswordLinkFailedState())}
        });
  }

  void getFriendInfo(String login) async {
    var resp = await CopainsDeRouteApi().getFriendInfo(login);
    if (resp.statusCode == 200) {
      UserDTO user = UserDTO.fromJson(resp.data);
      emit(FriendInfoLoadedState(user));
    } else {
      emit(FriendInfoErrorState());
    }
  }
}
