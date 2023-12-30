import 'package:copains_de_route/model/friends_dto.dart';
import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {
  final FriendsDTO friend;
  final String loginUser;

  const FriendListTile(
      {super.key, required this.friend, required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        leading: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png')),
        title: Text(loginUser == friend.sender ? friend.added : friend.sender,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing:
            IconButton(onPressed: () => {}, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
