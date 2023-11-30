import 'package:copains_de_route/components/event_details/event_details.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: CustomColorScheme.customOnPrimary,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Little image here")],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${event.name} - placeholder km",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              "Organisé par placeholder",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            Text(
              "Le ${DateFormat('dMMMMy')} à ${DateFormat.Hm()}",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            Text(
              "placeholder / ${event.maxParticipants} participants",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  // emit or navigator to open details
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventDetails(event: event)));
                },
                icon: const Icon(Icons.arrow_forward_outlined))
          ],
        )
      ],
    );
  }
}
