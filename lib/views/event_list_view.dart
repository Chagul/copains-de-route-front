import 'package:copains_de_route/components/list_events/event_card.dart';
import 'package:copains_de_route/components/list_events/list_events_cubit.dart';
import 'package:copains_de_route/components/list_events/list_events_state.dart';
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
        return SafeArea(child: _buildBody(context, state));
      },
    );
  }

  Widget _buildBody(BuildContext context, ListEventState state) {
    if (state is ListAllEventsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ListAllEventsLoadedState) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: state.data.eventList.length,
          itemBuilder: (context, index) {
            return EventCard(event: state.data.eventList[index]);
          },
        ),
      );
    }

    return const Center(child: Text("Pas d'événements :psad:"));
  }
}
