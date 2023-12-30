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
          else
            {emit(FriendRequestAlreadyExistsState())}
        });
  }

  Future<void> acceptFriend(int id) async {
    var resp = CopainsDeRouteApi().acceptFriend(id);
    resp.then((value) => {
          if (value.statusCode == 200)
            {emit(AddFriendSucceedState())}
          else if (value.statusCode == 404)
            {emit(AddFriendFailedState())}
          else
            {emit(FriendRequestAlreadyExistsState())}
        });
  }

  Future<void> denyFriend(int id) async {
    var resp = CopainsDeRouteApi().denyFriend(id);
    resp.then((value) => {
          if (value.statusCode == 200)
            {emit(AddFriendSucceedState())}
          else if (value.statusCode == 404)
            {emit(AddFriendFailedState())}
          else
            {emit(FriendRequestAlreadyExistsState())}
        });
  }
}
