import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class RouteInfos extends StatelessWidget {
  final Event event;

  const RouteInfos({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Informations sur le trajet",
                  style: TextStyle(
                      color: CustomColorScheme.customOnSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time,
                        color: CustomColorScheme.customOnSecondary),
                    Text(/*event.time*/ "Le 17 octobre 2023 à 14h30",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.add_road,
                        color: CustomColorScheme.customOnSecondary),
                    Text(/*event._getRoadTypes()*/ "Placeholder road types",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: CustomColorScheme.customError),
                    Text(/*event.startPoint*/ "Départ : Placeholder",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: CustomColorScheme.customError),
                    Text(/*event.endPoint*/ "Arrivée : Placeholder",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.compare_arrows,
                        color: CustomColorScheme.customError),
                    Text(/*event.startPoint*/ "Distance : Placeholder km",
                        style: TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => print("Plus d'infos"),
                        icon: const Icon(Icons.arrow_circle_right_outlined))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
