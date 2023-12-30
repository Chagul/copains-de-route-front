import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/login/login_state.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';

class CardStatistiquesFriend extends StatelessWidget {
  final String loginFriend;

  const CardStatistiquesFriend({Key? key, required this.loginFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LoginCubit>().getFriendInfo(loginFriend);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, loginState) {
        if (loginState is FriendInfoLoadedState) {
          return _buildCard(context, loginState.friend);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCard(BuildContext context, UserDTO friend) {
    return Card(
      color: CustomColorScheme.customBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).refreshUser();
                Navigator.of(context).pop();
              },
            ),
            Text(
              "$friend.login",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 77, 76, 76),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: CustomColorScheme.customPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatRow(Icons.directions_bike,
                      "A participé ${friend.numberEventsParticipated} événements"),
                  _buildStatRow(Icons.pin_drop,
                      "A créé à ${friend.numberEventsCreated} événements"),
                  _buildStatRow(
                      Icons.map, "A parcouru à ${friend.distanceTraveled} km"),
                  _buildStatRow(Icons.co2,
                      "A économisé ${friend.co2NotEmitted} g de CO2"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
