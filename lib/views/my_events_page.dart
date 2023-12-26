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
        child: Scaffold(
            body: DefaultTabController(
                length: 2,
                child: SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          text: "Mes événements créés",
                        ),
                        Tab(text: "Mes événements rejoints"),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      CreatedEventsListView(),
                      JoinedEventsListView(),
                    ],
                  ),
                )))));
  }
}
