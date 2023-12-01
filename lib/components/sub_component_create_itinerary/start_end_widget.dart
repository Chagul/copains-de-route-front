import 'package:copains_de_route/components/map/map_cubit.dart';
import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartEndWidget extends StatelessWidget {
  @override
  const StartEndWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(listener: (context, state) {
      if (state is DisplayWarning) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.warning)));
      }
    }, builder: (context, state) {
      return Card(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () =>
                          BlocProvider.of<MapCubit>(context).startPickStart(),
                      child: const Text("Départ")),
                  TextButton(
                      onPressed: () =>
                          BlocProvider.of<MapCubit>(context).startPickEnd(),
                      child: const Text("Arrivée")),
                  ElevatedButton(
                      onPressed: () => BlocProvider.of<MapCubit>(context)
                          .changeWidget(SubComponentCreateItineraryPage
                              .choseItineraryWidget),
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(color: Colors.black),
                      )),
                ])),
      );
    });
  }
}
