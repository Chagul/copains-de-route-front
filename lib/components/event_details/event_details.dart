import 'package:copains_de_route/components/event_details/comment_section.dart';
import 'package:copains_de_route/components/event_details/map_card.dart';
import 'package:copains_de_route/components/event_details/map_event_details.dart';
import 'package:copains_de_route/components/event_details/participants_infos.dart';
import 'package:copains_de_route/components/event_details/route_infos.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventCubit, DetailEventState>(
        builder: (context, state) => SafeArea(
                child: Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.black)),
                      const Text("Trajet",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
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
                              context.read<DetailEventCubit>().joined
                                  ? ElevatedButton(
                                      onPressed: () => {
                                            context
                                                .read<DetailEventCubit>()
                                                .participate(
                                                    context
                                                        .read<
                                                            DetailEventCubit>()
                                                        .event
                                                        .id,
                                                    "test"),
                                            context
                                                .read<DetailEventCubit>()
                                                .changeJoined(),
                                          },
                                      child: const Text("Rejoindre",
                                          style: TextStyle(
                                              color: CustomColorScheme
                                                  .customOnSecondary)))
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow),
                                      onPressed: () => {
                                            context
                                                .read<DetailEventCubit>()
                                                .unsubscribe(
                                                    context
                                                        .read<
                                                            DetailEventCubit>()
                                                        .event
                                                        .id,
                                                    "test"),
                                            context
                                                .read<DetailEventCubit>()
                                                .changeJoined(),
                                          },
                                      child: const Text("Rejoint",
                                          style: TextStyle(
                                              color: CustomColorScheme
                                                  .customOnSecondary))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          context
                                              .read<DetailEventCubit>()
                                              .event
                                              .promoter,
                                          style: const TextStyle(
                                              color: CustomColorScheme
                                                  .customOnSecondary)),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapEventDetails(
                                      event: context
                                          .read<DetailEventCubit>()
                                          .event,
                                    )));
                          },
                          child: MapCard(
                              event: context.read<DetailEventCubit>().event)),
                      const SizedBox(height: 10),
                      RouteInfos(event: context.read<DetailEventCubit>().event),
                      const SizedBox(height: 10),
                      ParticipantsInfos(
                          event: context.read<DetailEventCubit>().event),
                      const SizedBox(height: 10),
                      CommentSection(
                          event: context.read<DetailEventCubit>().event)
                    ],
                  ))),
                ]))));
  }
}
