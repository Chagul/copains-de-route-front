import 'package:copains_de_route/cubit/list_event/list_events_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/views/event_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageList extends StatelessWidget {
  const HomePageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ListEventCubit(ListAllEventsLoadingState())..getEvents(),
        child: const EventListView());
  }
}
