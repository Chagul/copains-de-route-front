import 'package:copains_de_route/model/event.dart';
import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  final Event event;

  const MapCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Card(
          child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: const Text("MAP HERE"),
      ))
    ]);
  }
}
