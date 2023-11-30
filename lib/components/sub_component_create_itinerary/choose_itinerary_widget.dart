import 'package:copains_de_route/components/map/map_cubit.dart';
import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoseItineraryTypeWidget extends StatelessWidget {
  const ChoseItineraryTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return Card(
          child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () => {
                              BlocProvider.of<MapCubit>(context).changeWidget(
                                  SubComponentCreateItineraryPage
                                      .drawItineraryWidget),
                              BlocProvider.of<MapCubit>(context).alternative =
                                  false,
                              BlocProvider.of<MapCubit>(context)
                                  .markerStepsInit = true,
                            },
                        child: const Text("Dessiner mon trajet")),
                    TextButton(
                        onPressed: () => {
                              BlocProvider.of<MapCubit>(context)
                                  .getDirectionsForPoints(),
                              BlocProvider.of<MapCubit>(context).changeWidget(
                                  SubComponentCreateItineraryPage
                                      .pickItineraryWidget),
                              BlocProvider.of<MapCubit>(context).alternative =
                                  true,
                            },
                        child: const Text("Recommendation de trajet")),
                    ElevatedButton(
                        onPressed: () => BlocProvider.of<MapCubit>(context)
                            .changeWidget(
                                SubComponentCreateItineraryPage.startEndWidget),
                        child: const Text(
                          "Retour",
                          style: TextStyle(color: Colors.black),
                        )),
                  ])));
    });
  }
}
