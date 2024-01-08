import 'package:copains_de_route/cubit/list_my_event/list_my_events_cubit.dart';
import 'package:copains_de_route/cubit/list_my_event/list_my_events_state.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_cubit.dart';
import 'package:copains_de_route/cubit/list_my_events_joined/list_my_events_joined_state.dart';
import 'package:copains_de_route/views/created_events_list.dart';
import 'package:copains_de_route/views/joined_events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ListMyEventsCubit>(
              create: (context) =>
                  ListMyEventsCubit(ListMyEventsStateInitial())),
          BlocProvider<ListMyEventsJoinedCubit>(
              create: (context) =>
                  ListMyEventsJoinedCubit(ListMyEventsJoinedStateInitial()))
        ],
        child: SafeArea(
            child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Center(child: Text("Mes événements")),
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          text: "Créés",
                        ),
                        Tab(text: "Rejoints"),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      CreatedEventsListView(),
                      JoinedEventsListView(),
                    ],
                  ),
                ))));
  }
}
