import 'package:copains_de_route/cubit/profil/profil_view_state.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfilViewCubit extends Cubit<ProfilViewState> {
  ProfilViewCubit() : super(ProfilViewInitial());

  settingsViewClicked() {
    emit(SettingsViewClicked());
  }

  friendClicked(int i) {
    emit(OtherProfileState(i));
  }

  moreFriendClicked() {}
}
