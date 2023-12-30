import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_cubit.dart';
import 'package:copains_de_route/cubit/profil/add_friend_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
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
        child: ListTile(
          leading: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png')),
          title: Text(loginUser == friend.sender ? friend.added : friend.sender,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: IconButton(
              onPressed: () async {
                await cubitFriend.deleteFriend(friend.id);
                await cubitLogin.refreshUser();
              },
              icon: const Icon(Icons.delete)),
        ),
      );
    });
  }
}
