import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
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
    return BlocBuilder<MapCreateItineraryCubit, MapCreateItineraryState>(
        builder: (context, state) {
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow),
                              onPressed: () => {
                                    context
                                        .read<MapCreateItineraryCubit>()
                                        .getDirectionsForPoints(),
                                  },
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow),
                              onPressed: () => {
                                    context
                                        .read<MapCreateItineraryCubit>()
                                        .clearSteps(),
                                    context
                                        .read<MapCreateItineraryCubit>()
                                        .changeWidget(
                                            SubComponentCreateItineraryPage
                                                .choseItineraryWidget)
                                  },
                              child: const Text(
                                "Retour",
                                style: TextStyle(color: Colors.black),
                              )),
                          if (state is MapPolylinesLoaded)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow),
                                onPressed: () => {
                                      context
                                          .read<MapCreateItineraryCubit>()
                                          .getDirectionsForPoints(),
                                      context
                                          .read<MapCreateItineraryCubit>()
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
    });
  }
}
