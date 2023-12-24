import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilViewCubit extends Cubit<ProfilViewState> {
  // ignore: prefer_typing_uninitialized_variables
  var login;
  // ignore: prefer_typing_uninitialized_variables
  var numberEventsCreated;
  // ignore: prefer_typing_uninitialized_variables
  var numberEventsParticipated;
  // ignore: prefer_typing_uninitialized_variables
  var distanceTraveled;
  // ignore: prefer_typing_uninitialized_variables
  var co2NotEmitted;

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
              login = value.data['login'],
              numberEventsCreated = value.data['numberEventsCreated'],
              numberEventsParticipated = value.data['numberEventsParticipated'],
              distanceTraveled = value.data['distanceTraveled'],
              co2NotEmitted = value.data['co2NotEmitted'],
            
              emit(MyProfileState(login, numberEventsCreated,
                  numberEventsParticipated, distanceTraveled, co2NotEmitted))}
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
              login = value.data['login'],
              numberEventsCreated = value.data['numberEventsCreated'],
              numberEventsParticipated = value.data['numberEventsParticipated'],
              distanceTraveled = value.data['distanceTraveled'],
              co2NotEmitted = value.data['co2NotEmitted'],
            
              emit(MyProfileState(login, numberEventsCreated,
                  numberEventsParticipated, distanceTraveled, co2NotEmitted))}
          else
            {emit(ErrorState())}
        });
  }


}
