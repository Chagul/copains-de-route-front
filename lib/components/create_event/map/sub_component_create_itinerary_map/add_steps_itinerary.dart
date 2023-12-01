import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class AddStepsItinerary extends StatelessWidget {
  @override
  const AddStepsItinerary({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: PointerInterceptor(
          child: Card(
            child: SizedBox(
                height: 200,
                width: 500,
                child: Column(children: [
                  const Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Ajouter des points de passage")])),
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        ElevatedButton(
                            onPressed: () =>
                                BlocProvider.of<MapCreateItineraryCubit>(
                                        context)
                                    .getDirectionsForPoints(),
                            child: const Text(
                              "Calculer un itinéraire",
                              style: TextStyle(color: Colors.black),
                            ))
                      ])),
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        ElevatedButton(
                            onPressed: () => {
                                  BlocProvider.of<MapCreateItineraryCubit>(
                                          context)
                                      .clearSteps(),
                                  BlocProvider.of<MapCreateItineraryCubit>(
                                          context)
                                      .changeWidget(
                                          SubComponentCreateItineraryPage
                                              .choseItineraryWidget)
                                },
                            child: const Text(
                              "Retour",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () => {
                                  BlocProvider.of<MapCreateItineraryCubit>(
                                          context)
                                      .getDirectionsForPoints(),
                                  BlocProvider.of<MapCreateItineraryCubit>(
                                          context)
                                      .changeWidget(
                                          SubComponentCreateItineraryPage
                                              .pickItineraryWidget)
                                },
                            child: const Text(
                              "Confirmer",
                              style: TextStyle(color: Colors.black),
                            ))
                      ])),
                ])),
          ),
        ));
  }
}
