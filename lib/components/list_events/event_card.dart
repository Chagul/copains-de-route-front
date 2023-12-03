import 'package:copains_de_route/components/event_details/event_details.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  TextStyle _getTitleTextStyle() {
    return const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: CustomColorScheme.customOnSecondary);
  }

  TextStyle _getNormalTextStyle() {
    return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: CustomColorScheme.customOnSecondary);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: CustomColorScheme.customOnPrimary,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Card(
        color: CustomColorScheme.customOnPrimary,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: CustomColorScheme.customOnSecondary),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.event)],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${event.name} - placeholder km",
                  style: _getTitleTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Organisé par placeholder",
                  style: _getNormalTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  //"Le ${DateFormat('dMMMMy')} à ${DateFormat.Hm()}",
                  "Le 17 octobre 2023 à 14h30",
                  style: _getNormalTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "placeholder / ${event.maxParticipants} participants",
                  style: _getNormalTextStyle(),
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
                    icon: const Icon(
                      Icons.arrow_forward_outlined,
                      color: CustomColorScheme.customOnSecondary,
                    ))
              ],
            )
          ],
        ));
  }
}
