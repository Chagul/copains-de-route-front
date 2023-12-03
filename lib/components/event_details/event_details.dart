import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: CustomColorScheme.customOnSecondary,
                  )),
              Text(
                event.name,
                style: const TextStyle(
                    color: CustomColorScheme.customOnSecondary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SingleChildScrollView(
              child: Center(
                  child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => print("Rejoindre"),
                      child: const Text("Rejoindre",
                          style: TextStyle(
                              color: CustomColorScheme.customOnSecondary))),
                  const Text("placeholder",
                      style:
                          TextStyle(color: CustomColorScheme.customOnSecondary))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Card(child: Text("MAP HERE"))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Expanded(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.access_time,
                                  color: CustomColorScheme.customOnSecondary),
                              Text(/*event.time*/ "Le 17 octobre 2023 à 14h30",
                                  style: const TextStyle(
                                      color:
                                          CustomColorScheme.customOnSecondary)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.add_road,
                                  color: CustomColorScheme.customOnSecondary),
                              Text(
                                  /*event._getRoadTypes()*/ "Placeholder road types",
                                  style: TextStyle(
                                      color:
                                          CustomColorScheme.customOnSecondary)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on,
                                  color: CustomColorScheme.customError),
                              Text(/*event.startPoint*/ "Départ : Placeholder",
                                  style: TextStyle(
                                      color:
                                          CustomColorScheme.customOnSecondary)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on,
                                  color: CustomColorScheme.customError),
                              Text(/*event.endPoint*/ "Arrivée : Placeholder",
                                  style: TextStyle(
                                      color:
                                          CustomColorScheme.customOnSecondary)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.compare_arrows,
                                  color: CustomColorScheme.customError),
                              Text(
                                  /*event.startPoint*/ "Distance : Placeholder km",
                                  style: TextStyle(
                                      color:
                                          CustomColorScheme.customOnSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ))),
        ]),
      ),
    );
  }
}
