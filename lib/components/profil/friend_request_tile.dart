import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequestTile extends StatelessWidget {
  const FriendRequestTile(
      {super.key, required this.friend, required this.loginUser});

  final FriendsDTO friend;
  final String loginUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendCubit, AddFriendState>(
        builder: (context, state) {
      final cubitFriend = BlocProvider.of<AddFriendCubit>(context);
      final cubitLogin = BlocProvider.of<LoginCubit>(context);
      return Card(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ProfilePictureUtils.getFriendProfilePicWidget(friend, loginUser),
              const SizedBox(width: 20),
              Text(loginUser == friend.sender ? friend.added : friend.sender,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColorScheme.customSecondaryColor),
              onPressed: () async {
                await cubitFriend.acceptFriend(friend.id);
                await cubitLogin.refreshUser();
              },
              child: const Text(
                "ACCEPTER",
                style: TextStyle(color: CustomColorScheme.customOnSurface),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColorScheme.customSecondaryColor),
                onPressed: () async {
                  await cubitFriend.denyFriend(friend.id);
                  await cubitLogin.refreshUser();
                },
                child: const Text("REFUSER",
                    style:
                        TextStyle(color: CustomColorScheme.customOnSurface))),
          ],
        )
      ]));
    });
  }
}
