import 'package:copains_de_route/components/event_details/route_infos_more_infos.dart';
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
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Informations sur le trajet",
                  style: TextStyle(
                      color: CustomColorScheme.customOnSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.access_time,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 5),
                    Text("Le ${event.startDate} à ${event.startTime}",
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.edit_road,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 5),
                    Text("${event.getRoadTypes()}",
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on,
                        color: CustomColorScheme.customError),
                    const SizedBox(width: 5),
                    Text("Départ : ${event.startAddress}",
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on,
                        color: CustomColorScheme.customError),
                    const SizedBox(width: 5),
                    Text("Arrivée : ${event.endAddress}",
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.compare_arrows,
                        color: CustomColorScheme.customError),
                    const SizedBox(width: 5),
                    Text("Distance : ${event.distance} km",
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSecondary)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RouteInfosMoreInfos(event: event))),
                        icon: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: CustomColorScheme.customOnSecondary,
                        ))
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
