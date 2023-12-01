import 'package:copains_de_route/components/list_events/event_card.dart';
import 'package:copains_de_route/components/list_events/list_events_cubit.dart';
import 'package:copains_de_route/components/list_events/list_events_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListView extends StatelessWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context) {
    var listEventsCubit = context.read<ListEventCubit>();
    return BlocConsumer<ListEventCubit, ListEventState>(
      listener: (context, state) {
        // si on a un state ListEventDetailsState -> Navigatore.push pour aller sur la page de détails
      },
      builder: (context, state) {
        return Scaffold(body: _buildBody(context, state));
      },
    );
  }

  Widget _buildBody(BuildContext context, ListEventState state) {
    if (state is ListAllEventsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ListAllEventsLoadedState) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.map),
                    color: CustomColorScheme.customOnSecondary,
                    onPressed: () => print("map"),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        print(text);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Rechercher ..."),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        print("Date");
                      },
                      child: Text("Date")),
                  ElevatedButton(
                      onPressed: () {
                        print("Distance");
                      },
                      child: Text("Distance")),
                  ElevatedButton(
                      onPressed: () {
                        print("Participants");
                      },
                      child: Text("Participants")),
                  ElevatedButton(
                    onPressed: () {
                      print("Filtres");
                    },
                    child: const Icon(Icons.table_rows_sharp),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.data.eventList.length,
                  itemBuilder: (context, index) {
                    return EventCard(event: state.data.eventList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const Center(child: Text("Pas d'événements :psad:"));
  }

  Widget _buildHeader(BuildContext context, ListEventState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.map),
            TextField(
              onChanged: (text) {
                print(text);
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Rechercher ..."),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  print("Date");
                },
                child: Text("Date")),
            ElevatedButton(
                onPressed: () {
                  print("Distance");
                },
                child: Text("Distance")),
            ElevatedButton(
                onPressed: () {
                  print("Participants");
                },
                child: Text("Participants")),
            ElevatedButton(
              onPressed: () {
                print("Filtres");
              },
              child: const Icon(Icons.table_rows_sharp),
            )
          ],
        )
      ],
    );
  }
}
