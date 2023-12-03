import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilViewCubit extends Cubit<ProfilViewState> {
  ProfilViewCubit() : super(ProfilViewInitial());

  settingsViewClicked() {
    emit(SettingsViewClicked());
  }

  updateUser() {
    print("sending api call");
  }

  friendClicked(int i) {
    emit(FriendViewClicked());
  }

  getInfo() {
    return "get info";
  }
}
