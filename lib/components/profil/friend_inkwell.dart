import 'package:copains_de_route/components/commons/card_statistiques_friend.dart';
import 'package:copains_de_route/components/commons/row_image_text.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/model/friends_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendInkwell extends StatelessWidget {
  final FriendsDTO friend;

  const FriendInkwell({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return InkWell(
          onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const CardStatistiquesFriend();
                }))
              },
          child: RowImageText(
            friend: friend,
            loginUser: BlocProvider.of<LoginCubit>(context).user.login,
            text:
                BlocProvider.of<LoginCubit>(context).user.login == friend.sender
                    ? friend.added
                    : friend.sender,
          ));
    });
  }
}
