import 'package:copains_de_route/components/event_details/comment_section.dart';
import 'package:copains_de_route/components/event_details/map_card.dart';
import 'package:copains_de_route/components/event_details/participants_infos.dart';
import 'package:copains_de_route/components/event_details/route_infos.dart';
import 'package:copains_de_route/components/list_events/list_events_cubit.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
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
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () =>
                          context.read<ListEventCubit>().participate(event.id),
                      child: const Text("Rejoindre",
                          style: TextStyle(
                              color: CustomColorScheme.customOnSecondary))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(event.promoter,
                              style: const TextStyle(
                                  color: CustomColorScheme.customOnSecondary)),
                          const Icon(Icons.person)
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 10),
          InkWell(
              onTap: () {
                print("map");
              },
              child: MapCard(event: event)),
          const SizedBox(height: 10),
          RouteInfos(event: event),
          const SizedBox(height: 10),
          ParticipantsInfos(event: event),
          const SizedBox(height: 10),
          CommentSection(event: event)
        ],
      ))),
    ])));
  }
}
