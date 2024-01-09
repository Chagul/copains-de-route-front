import 'package:copains_de_route/components/commons/card_statistiques_friend.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendListTile extends StatelessWidget {
  final FriendsDTO friend;
  final String loginUser;

  const FriendListTile(
      {super.key, required this.friend, required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendCubit, AddFriendState>(
        builder: (context, state) {
      final cubitFriend = BlocProvider.of<AddFriendCubit>(context);
      final cubitLogin = BlocProvider.of<LoginCubit>(context);
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 75,
                child: InkWell(
                  child: Row(children: [
                    Expanded(
                        flex: 20,
                        child: ProfilePictureUtils.getFriendProfilePicWidget(
                            friend, loginUser)),
                    const Spacer(flex: 5),
                    Expanded(
                        flex: 75,
                        child: Text(
                            loginUser == friend.sender
                                ? friend.added
                                : friend.sender,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                  ]),
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      String loginOfFriend =
                          BlocProvider.of<LoginCubit>(context).user.login ==
                                  friend.sender
                              ? friend.added
                              : friend.sender;
                      return CardStatistiquesFriend(
                          friend: friend, loginOfFriend: loginOfFriend);
                    }))
                  },
                )),
            Expanded(
                flex: 25,
                child: IconButton(
                    onPressed: () async {
                      await cubitFriend.deleteFriend(friend.id);
                      await cubitLogin.refreshUser();
                    },
                    icon: const Icon(Icons.delete)))
          ],
        ),
      );
    });
  }
}
