import 'package:copains_de_route/api/copains_de_route_api.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit(super.initialState);

  TextEditingController loginToAdd = TextEditingController();

  void addFriend() async {
    var resp = CopainsDeRouteApi().addFriend(loginToAdd.text);
    resp.then((value) => {
          loginToAdd.clear(),
          if (value.statusCode == 200)
            {emit(AddFriendSucceedState())}
          else if (value.statusCode == 404)
            {emit(AddFriendFailedState())}
          else if (value.statusCode == 400)
            {emit((FriendRequestCannotAddItSelfState()))}
          else
            {emit(FriendRequestAlreadyExistsState())}
        });
  }

  Future<void> acceptFriend(int id) async {
    var resp = await CopainsDeRouteApi().acceptFriend(id);
    if (resp.statusCode == 200) {
      emit(AcceptFriendSucceedState());
    } else if (resp.statusCode == 404) {
      emit(AcceptFriendFailedState());
    } else {
      emit(AcceptOrDenyFriendFailedState());
    }
  }

  Future<void> denyFriend(int id) async {
    var resp = await CopainsDeRouteApi().denyFriend(id);
    if (resp.statusCode == 200) {
      emit(DenyFriendSucceedState());
    } else if (resp.statusCode == 404) {
      emit(DenyFriendFailedState());
    } else {
      emit(AcceptOrDenyFriendFailedState());
    }
  }

  Future<void> deleteFriend(int id) async {
    var resp = await CopainsDeRouteApi().deleteFriend(id);
    if (resp.statusCode == 200) {
      emit(DeleteFriendSucceedState());
    } else if (resp.statusCode == 404) {
      emit(DeleteFriendFailedState());
    } else {
      emit(AcceptOrDenyFriendFailedState());
    }
  }
}
