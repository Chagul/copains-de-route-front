import 'package:copains_de_route/components/event_details/comment_section.dart';
import 'package:copains_de_route/components/event_details/participants_infos.dart';
import 'package:copains_de_route/components/event_details/route_infos.dart';
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
              RouteInfos(event: event),
              ParticipantsInfos(event: event),
              CommentSection(event: event)
            ],
          ))),
        ]),
      ),
    );
  }
}
