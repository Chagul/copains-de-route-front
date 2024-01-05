import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/list_events/event_card.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_cubit.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinedEventsListView extends StatelessWidget {
  const JoinedEventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMyEventsJoinedCubit, ListMyEventsJoinedState>(
        builder: (context, state) {
      if (state is ListMyEventsJoinedStateInitial) {
        BlocProvider.of<ListMyEventsJoinedCubit>(context)
            .getEventsParticipated();
        return const LoadingWidget();
      }
      if (state is ListMyEventsJoinedLoadedState || state is ListSortedState) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: context
                                    .read<ListMyEventsJoinedCubit>()
                                    .sortedByDate
                                ? Colors.lightBlue
                                : Colors.white,
                            padding: const EdgeInsets.all(5.0),
                            side: const BorderSide(color: Colors.black)),
                        onPressed: () {
                          context
                              .read<ListMyEventsJoinedCubit>()
                              .sortEventsByDate();
                        },
                        child: Text("Date", style: _getButtonTextStyle())),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context
                                  .read<ListMyEventsJoinedCubit>()
                                  .sortedByDistance
                              ? Colors.lightBlue
                              : Colors.white,
                          padding: const EdgeInsets.all(5.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          context
                              .read<ListMyEventsJoinedCubit>()
                              .sortEventsByDistance();
                        },
                        child: Text("Distance", style: _getButtonTextStyle())),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context
                                  .read<ListMyEventsJoinedCubit>()
                                  .sortedByParticipants
                              ? Colors.lightBlue
                              : Colors.white,
                          padding: const EdgeInsets.all(5.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                        onPressed: () {
                          context
                              .read<ListMyEventsJoinedCubit>()
                              .sortEventsByParticipants();
                        },
                        child: Text(
                          "Participants",
                          style: _getButtonTextStyle(),
                        )),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: context
                        .read<ListMyEventsJoinedCubit>()
                        .eventsJoined
                        .eventList
                        .length,
                    itemBuilder: (context, index) {
                      return EventCard(
                          refreshList: context
                              .read<ListMyEventsJoinedCubit>()
                              .getEventsParticipated,
                          event: context
                              .read<ListMyEventsJoinedCubit>()
                              .eventsJoined
                              .eventList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is ListMyEventsJoinedNoContentState) {
        return const Center(
          child: Text("Aucun événement participé"),
        );
      } else {
        return const LoadingWidget();
      }
    });
  }

  TextStyle _getButtonTextStyle() {
    return const TextStyle(color: CustomColorScheme.customOnSecondary);
  }
}
