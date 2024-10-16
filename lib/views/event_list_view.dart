import 'package:copains_de_route/components/list_events/event_card.dart';
import 'package:copains_de_route/components/list_events/filter_page.dart';
import 'package:copains_de_route/components/map_event.dart';
import 'package:copains_de_route/cubit/filter_form_cubit/filter_form_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListView extends StatelessWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListEventCubit, ListEventState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(body: _buildBody(context, state));
      },
    );
  }

  Widget _buildBody(BuildContext context, ListEventState state) {
    if (state is ListAllEventsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.map),
                  color: CustomColorScheme.customOnSecondary,
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        value: context.read<ListEventCubit>(),
                        child: const MapEvent());
                  })),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: TextField(
                        style: const TextStyle(
                            color: CustomColorScheme.customOnSurface),
                        onSubmitted: (text) {
                          context
                              .read<ListEventCubit>()
                              .searchEvents(text.toLowerCase());
                        },
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            constraints: BoxConstraints(maxHeight: 50),
                            hintText: "Rechercher ...",
                            suffixIcon: Icon(
                              Icons.search,
                              color: CustomColorScheme.customOnSecondary,
                            )),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            context.read<ListEventCubit>().sortedByDate
                                ? Colors.lightBlue
                                : Colors.white,
                        padding: const EdgeInsets.all(5.0),
                        side: const BorderSide(
                            color: CustomColorScheme.customOnSurface)),
                    onPressed: () {
                      context.read<ListEventCubit>().sortEventsByDate();
                    },
                    child: Text("Date", style: _getButtonTextStyle())),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.read<ListEventCubit>().sortedByDistance
                              ? Colors.lightBlue
                              : Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      side: const BorderSide(
                          color: CustomColorScheme.customOnSurface),
                    ),
                    onPressed: () {
                      context.read<ListEventCubit>().sortEventsByDistance();
                    },
                    child: Text("Distance", style: _getButtonTextStyle())),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.read<ListEventCubit>().sortedByParticipants
                              ? Colors.lightBlue
                              : Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      side: const BorderSide(
                          color: CustomColorScheme.customOnSurface),
                    ),
                    onPressed: () {
                      context.read<ListEventCubit>().sortEventsByParticipants();
                    },
                    child: Text(
                      "Participants",
                      style: _getButtonTextStyle(),
                    )),
                if (!context.read<ListEventCubit>().filtered)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      side: const BorderSide(
                          color: CustomColorScheme.customOnSurface),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(
                            value: context.read<ListEventCubit>(),
                            child: BlocProvider(
                                create: (_) => FilterFormCubit(),
                                child: const FilterPage()));
                      }));
                    },
                    child: const Icon(Icons.table_rows_sharp,
                        color: CustomColorScheme.customOnSecondary),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      side: const BorderSide(
                          color: CustomColorScheme.customOnSurface),
                    ),
                    onPressed: () {
                      context.read<ListEventCubit>().resetFilter();
                    },
                    child: const Icon(Icons.cancel,
                        color: CustomColorScheme.customOnSecondary),
                  )
              ],
            ),
            if (state is ListAllEventsLoadedState ||
                state is ListSortedState ||
                state is ListChangedState ||
                state is ListFilteredState) ...[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: context
                      .read<ListEventCubit>()
                      .dataDisplayed
                      .eventList
                      .length,
                  itemBuilder: (context, index) {
                    return EventCard(
                        refreshList: context.read<ListEventCubit>().getEvents,
                        event: context
                            .read<ListEventCubit>()
                            .dataDisplayed
                            .eventList[index]);
                  },
                ),
              )
            ] else ...[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Il n'y aucun événement prévu pour le moment. Créez-en un !",
                    style:
                        TextStyle(color: CustomColorScheme.customOnSecondary),
                  ))
            ],
          ],
        ),
      ),
    );
  }

  TextStyle _getButtonTextStyle() {
    return const TextStyle(color: CustomColorScheme.customOnSecondary);
  }
}
