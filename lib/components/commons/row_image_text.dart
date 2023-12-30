import 'package:copains_de_route/model/friends_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';

class RowImageText extends StatelessWidget {
  final FriendsDTO friend;
  final String loginUser;
  final String text;
  const RowImageText(
      {super.key,
      required this.text,
      required this.friend,
      required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: CustomColorScheme.customPrimaryColor,
        child: ProfilePictureUtils.getFriendProfilePicWidget(friend, loginUser),
      ),
      const SizedBox(width: 10),
      Text(text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
    ]);
  }
}
