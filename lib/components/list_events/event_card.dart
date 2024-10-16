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
        fontSize: 16,
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
        child: Column(
          children: [
            ListTile(
              leading: event.visibility == "PUBLIC"
                  ? const Icon(Icons.public)
                  : const Icon(Icons.lock),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      event.name,
                      style: _getTitleTextStyle(),
                    ),
                    Text(
                      "${event.distance} km",
                      style: _getTitleTextStyle(),
                    ),
                  ],
                ),
              ),
              subtitle: Column(children: [
                Text(
                  "Organisé par ${event.promoter}",
                  style: _getNormalTextStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Le ${event.getDateFormated()} à ${event.startTime}",
                  style: _getNormalTextStyle(),
                ),
                Text(
                  "${event.participants.length} / ${event.maxParticipants} participants",
                  style: _getNormalTextStyle(),
                ),
              ]),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return BlocProvider<DetailEventCubit>(
                          create: (context) => DetailEventCubit(event: event)
                            ..updateJoined(context.read<LoginCubit>().user),
                          child: EventDetails(refreshList: refreshList));
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_outlined,
                    color: CustomColorScheme.customOnSecondary,
                  )),
            ),
          ],
        ));
  }
}
