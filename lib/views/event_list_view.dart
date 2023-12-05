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
                    icon: const Icon(Icons.map),
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
                          hintText: "Rechercher ...",
                          suffixIcon: Icon(
                            Icons.search,
                            color: CustomColorScheme.customOnSecondary,
                          )),
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
                      child: Text("Date", style: _getButtonTextStyle())),
                  ElevatedButton(
                      onPressed: () {
                        print("Distance");
                      },
                      child: Text("Distance", style: _getButtonTextStyle())),
                  ElevatedButton(
                      onPressed: () {
                        print("Participants");
                      },
                      child: Text(
                        "Participants",
                        style: _getButtonTextStyle(),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      print("Filtres");
                    },
                    child: const Icon(Icons.table_rows_sharp,
                        color: CustomColorScheme.customOnSecondary),
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

    return const Center(
        child: Text(
      "Pas d'événements :psad:",
      style: TextStyle(color: CustomColorScheme.customOnSecondary),
    ));
  }

  TextStyle _getButtonTextStyle() {
    return const TextStyle(color: CustomColorScheme.customOnSecondary);
  }
}
