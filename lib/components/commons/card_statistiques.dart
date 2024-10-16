import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CardStatistiques extends StatelessWidget {
  final String evenementJoinedNumber;
  final String evenementCreatedNumber;
  final String kmDriven;
  final String co2Saved;

  const CardStatistiques(
      {Key? key,
      required this.evenementJoinedNumber,
      required this.evenementCreatedNumber,
      required this.kmDriven,
      required this.co2Saved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      const Align(
          alignment: Alignment.topLeft,
          child: Text("Statistiques:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline))),
      Card(
          color: CustomColorScheme.customPrimaryColor.withOpacity(0.5),
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    const Icon(Icons.directions_bike,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 10),
                    Text(
                      "A participé à $evenementJoinedNumber événement(s)",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.pin_drop,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 10),
                    Text(
                      "A créé $evenementCreatedNumber événement(s)",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.map,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 10),
                    Text(
                      "A parcouru $kmDriven km",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    const Icon(Icons.co2,
                        color: CustomColorScheme.customOnSecondary),
                    const SizedBox(width: 10),
                    Text(
                      "A économisé $co2Saved g de CO2",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ]),
                  const SizedBox(height: 20),
                ]),
              ]))),
    ]);
  }
}
