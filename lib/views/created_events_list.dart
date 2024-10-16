import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/list_events/event_card.dart';
import 'package:copains_de_route/cubit/list_my_event/list_my_events_cubit.dart';
import 'package:copains_de_route/cubit/list_my_event/list_my_events_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatedEventsListView extends StatelessWidget {
  const CreatedEventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListMyEventsCubit, ListMyEventsState>(
        builder: (context, state) {
      if (state is ListMyEventsStateInitial) {
        BlocProvider.of<ListMyEventsCubit>(context).getMyEvents();
        return const LoadingWidget();
      }
      if (state is ListMyEventsLoadedState || state is ListSortedState) {
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
                            backgroundColor:
                                context.read<ListMyEventsCubit>().sortedByDate
                                    ? Colors.lightBlue
                                    : Colors.white,
                            padding: const EdgeInsets.all(5.0),
                            side: const BorderSide(
                                color: CustomColorScheme.customOnSurface)),
                        onPressed: () {
                          context.read<ListMyEventsCubit>().sortEventsByDate();
                        },
                        child: Text("Date", style: _getButtonTextStyle())),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              context.read<ListMyEventsCubit>().sortedByDistance
                                  ? Colors.lightBlue
                                  : Colors.white,
                          padding: const EdgeInsets.all(5.0),
                          side: const BorderSide(
                              color: CustomColorScheme.customOnSurface),
                        ),
                        onPressed: () {
                          context
                              .read<ListMyEventsCubit>()
                              .sortEventsByDistance();
                        },
                        child: Text("Distance", style: _getButtonTextStyle())),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context
                                  .read<ListMyEventsCubit>()
                                  .sortedByParticipants
                              ? Colors.lightBlue
                              : Colors.white,
                          padding: const EdgeInsets.all(5.0),
                          side: const BorderSide(
                              color: CustomColorScheme.customOnSurface),
                        ),
                        onPressed: () {
                          context
                              .read<ListMyEventsCubit>()
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
                        .read<ListMyEventsCubit>()
                        .myEvents
                        .eventList
                        .length,
                    itemBuilder: (context, index) {
                      return EventCard(
                          refreshList:
                              context.read<ListMyEventsCubit>().getMyEvents,
                          event: context
                              .read<ListMyEventsCubit>()
                              .myEvents
                              .eventList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is ListMyEventsNoContentState) {
        return const Center(
          child: Text("Aucun événement créé"),
        );
      } else {
        return const LoadingWidget();
      }
    });
  }
}

TextStyle _getButtonTextStyle() {
  return const TextStyle(color: CustomColorScheme.customOnSecondary);
}
