abstract class ProfilViewState {}

class ProfilViewInitial extends ProfilViewState {}

class SettingsViewClicked extends ProfilViewState {}

class FriendViewClicked extends ProfilViewState {}

class MyProfileState extends ProfilViewState {
  final String login;
  final int numberEventsCreated;
  final int numberEventsParticipated;
  final int distanceTraveled;
  final int co2NotEmitted;

  MyProfileState(this.login, this.numberEventsCreated,
      this.numberEventsParticipated, this.distanceTraveled, this.co2NotEmitted);

}

class OtherProfileState extends ProfilViewState {
  final int id;

  OtherProfileState(this.id);
}

class LoadingState extends ProfilViewState {}

class ErrorState extends ProfilViewState {}