import 'package:copains_de_route/components/event_details/event_details.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/model/event.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function refreshList;

  const EventCard({super.key, required this.event, required this.refreshList});

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
    return _buildBody(context);
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
                  "${event.name} - ${event.distance} km",
                  style: _getTitleTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Organisé par ${event.promoter}",
                  style: _getNormalTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Le ${event.startDate} à ${event.startTime}",
                  style: _getNormalTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${event.participants.length} / ${event.maxParticipants} participants",
                  style: _getNormalTextStyle(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return BlocProvider<DetailEventCubit>(
                            create: (context) => DetailEventCubit(event: event)
                              ..updateJoined(context.read<LoginCubit>().user),
                            child: EventDetails(refreshList: refreshList));
                      }));
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
