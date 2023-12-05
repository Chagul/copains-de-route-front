abstract class ProfilViewState {}

class ProfilViewInitial extends ProfilViewState {}

class SettingsViewClicked extends ProfilViewState {}

class FriendViewClicked extends ProfilViewState {}

class MyProfileState extends ProfilViewState {}

class OtherProfileState extends ProfilViewState {
  final int id;

  OtherProfileState(this.id);
}

class LoadingState extends ProfilViewState {}