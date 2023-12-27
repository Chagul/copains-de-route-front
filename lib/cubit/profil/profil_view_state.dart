import 'package:copains_de_route/model/user_dto.dart';

abstract class ProfilViewState {
}

class ProfilViewInitial extends ProfilViewState {}

class SettingsViewClicked extends ProfilViewState {}

class FriendViewClicked extends ProfilViewState {}



class MyProfileState extends ProfilViewState {
  UserDTO userdto;

  MyProfileState(this.userdto);

  String get login => this.userdto.login;

}

class OtherProfileState extends ProfilViewState {
  final int id;

  OtherProfileState(this.id);
}

class LoadingState extends ProfilViewState {}

class ErrorState extends ProfilViewState {}