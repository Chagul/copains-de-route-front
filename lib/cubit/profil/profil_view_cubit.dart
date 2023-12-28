import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilViewCubit extends Cubit<ProfilViewState> {
  UserDTO userdto = UserDTO(
      login: 'login',
      numberEventsCreated: 0,
      numberEventsParticipated: 0,
      distanceTraveled: 0,
      co2NotEmitted: 0,
      profilePicLocation: null);

  late String login;
  late int numberEventsCreated;
  late int numberEventsParticipated;
  late double distanceTraveled;
  late double co2NotEmitted;
  late String? profilePicLocation;

  ProfilViewCubit() : super(ProfilViewInitial());

  settingsViewClicked() {
    emit(SettingsViewClicked());
  }

  friendClicked(int i) {
    emit(OtherProfileState(i));
  }

  getInfo() {
    emit(LoadingState());
    var response = CopainsDeRouteApi().getUser();

    response.then((value) => {
          if (value.statusCode == 200)
            {
              userdto = UserDTO(
                  login: value.data['login'],
                  numberEventsCreated: value.data['numberEventsCreated'],
                  numberEventsParticipated:
                      value.data['numberEventsParticipated'],
                  distanceTraveled: value.data['distanceTraveled'],
                  co2NotEmitted: value.data['co2NotEmitted'],
                  profilePicLocation: value.data['profilePicLocation']),
              emit(MyProfileState(userdto))
            }
          else
            {emit(ErrorState())}
        });
  }

  moreFriendClicked() {}

  waitLoading() {
    emit(LoadingState());
    var response = CopainsDeRouteApi().getUser();

    response.then((value) => {
          if (value.statusCode == 200)
            {
              userdto = UserDTO(
                  login: value.data['login'],
                  numberEventsCreated: value.data['numberEventsCreated'],
                  numberEventsParticipated:
                      value.data['numberEventsParticipated'],
                  distanceTraveled: value.data['distanceTraveled'],
                  co2NotEmitted: value.data['co2NotEmitted'],
                  profilePicLocation: value.data['profilePicLocation']),
              emit(MyProfileState(userdto))
            }
          else
            {emit(ErrorState())}
        });
  }
}
