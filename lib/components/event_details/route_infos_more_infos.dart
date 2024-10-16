import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class RouteInfosMoreInfos extends StatelessWidget {
  final Event event;

  const RouteInfosMoreInfos({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back,
                            color: CustomColorScheme.customOnSurface)),
                    Text(event.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColorScheme.customOnSurface))
                  ],
                ),
                Expanded(
                    child: Card(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildRow(Icons.location_on, Colors.blue,
                                "Départ : ${event.startAddress}"),
                            const SizedBox(height: 10),
                            _buildRow(
                                Icons.location_on,
                                CustomColorScheme.customError,
                                "Arrivée : ${event.endAddress}"),
                            const SizedBox(height: 10),
                            _buildRow(
                                Icons.compare_arrows,
                                CustomColorScheme.customOnSecondary,
                                "Distance : ${event.distance} km"),
                            const SizedBox(height: 10),
                            _buildRow(
                                Icons.edit_road,
                                CustomColorScheme.customOnSecondary,
                                "Terrain(s) : ${event.getRoadTypes()}"),
                            const SizedBox(height: 10),
                            _buildRow(
                                Icons.pedal_bike,
                                CustomColorScheme.customOnSecondary,
                                "Vélo(s) recommandé(s) : ${event.getBikeTypes()}"),
                            const SizedBox(height: 10),
                            _buildRow(
                                Icons.person,
                                CustomColorScheme.customOnSecondary,
                                "${event.participants.length} / ${event.maxParticipants} participants"),
                            const SizedBox(height: 10),
                            _buildDescription()
                          ],
                        )),
                  ),
                )),
              ]))),
    );
  }

  Widget _buildRow(IconData icon, Color iconColor, String text) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Flexible(
            child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: CustomColorScheme.customOnSecondary),
        ))
      ],
    );
  }

  Widget _buildDescription() {
    return Row(
      children: [
        Flexible(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Description : ",
                        style: TextStyle(
                            fontSize: 14,
                            color: CustomColorScheme.customOnSecondary,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(event.description,
                        style: const TextStyle(
                            fontSize: 14,
                            color: CustomColorScheme.customOnSecondary))
                  ],
                )))
      ],
    );
  }
}
