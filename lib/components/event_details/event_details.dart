import 'package:copains_de_route/components/event_details/comment_section.dart';
import 'package:copains_de_route/components/event_details/map_card.dart';
import 'package:copains_de_route/components/event_details/map_event_details.dart';
import 'package:copains_de_route/components/event_details/participants_infos.dart';
import 'package:copains_de_route/components/event_details/route_infos.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_state.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/profile_picture_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetails extends StatelessWidget {
  final Function refreshList;

  const EventDetails({super.key, required this.refreshList});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailEventCubit, DetailEventState>(
        listener: (context, state) {
          if (state is DeleteEventSucceedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("L'événement a été supprimé")));
            refreshList();
            Navigator.pop(context);
          }
        },
        builder: (context, state) => SafeArea(
                child: Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              {refreshList(), Navigator.pop(context)},
                          icon: const Icon(Icons.arrow_back,
                              color: CustomColorScheme.customOnSurface)),
                      Flexible(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                  context.read<DetailEventCubit>().event.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          CustomColorScheme.customOnSurface))))
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (context
                                      .read<DetailEventCubit>()
                                      .event
                                      .promoter !=
                                  context.read<LoginCubit>().user.login)
                                !context.read<DetailEventCubit>().joined
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
                                                      context
                                                          .read<LoginCubit>()
                                                          .user),
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
                                                      context
                                                          .read<LoginCubit>()
                                                          .user),
                                            },
                                        child: const Text("Rejoint",
                                            style: TextStyle(
                                                color: CustomColorScheme
                                                    .customOnSecondary))),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Par ${context.read<DetailEventCubit>().event.promoter}",
                                          style: const TextStyle(
                                              color: CustomColorScheme
                                                  .customOnSecondary)),
                                      const SizedBox(width: 10),
                                      ProfilePictureUtils
                                          .getEventPromoterProfilePicWidget(
                                              context),
                                    ],
                                  ),
                                ],
                              ),
                              if (context
                                      .read<DetailEventCubit>()
                                      .event
                                      .promoter ==
                                  context.read<LoginCubit>().user.login) ...{
                                const Spacer(),
                                PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      const PopupMenuItem(
                                          value: "Modifier",
                                          child: Text("Modifier")),
                                      const PopupMenuItem(
                                          value: "Supprimer",
                                          child: Text("Supprimer")),
                                    ];
                                  },
                                  onSelected: (value) {
                                    if (value == "Modifier") {
                                      var event = context
                                          .read<DetailEventCubit>()
                                          .event;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Modification de l'événement ${event.name} : A venir !")));
                                    } else if (value == "Supprimer") {
                                      context
                                          .read<DetailEventCubit>()
                                          .deleteEvent(context
                                              .read<DetailEventCubit>()
                                              .event
                                              .id);
                                    }
                                  },
                                )
                              },
                            ],
                          )),
                      const SizedBox(height: 10),
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return BlocProvider.value(
                                  value: context.read<DetailEventCubit>(),
                                  child: MapEventDetails(
                                      event: context
                                          .read<DetailEventCubit>()
                                          .event));
                            }));
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
