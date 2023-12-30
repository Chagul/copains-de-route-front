import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/model/user_dto.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';

class CardStatistiquesFriend extends StatelessWidget {
  final String loginFriend;

  const CardStatistiquesFriend({Key? key, required this.loginFriend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDTO>(
      future: BlocProvider.of<LoginCubit>(context).getFriendInfo(loginFriend),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        } else {
          var numberEventsCreated = snapshot.data!.numberEventsCreated;
          var numberEventsParticipated = snapshot.data!.numberEventsParticipated;
          var distanceTraveled = snapshot.data!.distanceTraveled;
          var co2NotEmitted = snapshot.data!.co2NotEmitted;


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
                  // Bouton de retour à la page précédente
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop(); // Retour à la page précédente
                    },
                  ),
                  const Text(
                    "Statistiques :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
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
                        _buildStatRow(Icons.directions_bike, "A participé à $numberEventsParticipated événements"),
                        _buildStatRow(Icons.pin_drop, "A créé à $numberEventsCreated événements"),
                        _buildStatRow(Icons.map, "A parcouru à $distanceTraveled km"),
                        _buildStatRow(Icons.co2, "A économisé $co2NotEmitted g de CO2"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
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
