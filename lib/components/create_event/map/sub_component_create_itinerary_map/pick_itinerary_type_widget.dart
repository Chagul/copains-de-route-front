import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickItineraryType extends StatelessWidget {
  const PickItineraryType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCreateItineraryCubit, MapCreateItineraryState>(
        builder: (context, state) {
      return Card(
          color: CustomColorScheme.customSecondaryColor,
          child: SizedBox(
              height: 200,
              width: 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(200, 40),
                            backgroundColor:
                                CustomColorScheme.customPrimaryColor),
                        onPressed: () => {
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .changeWidget(SubComponentCreateItineraryPage
                                      .drawItineraryWidget),
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .alternative = false,
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .markerStepsInit = true,
                            },
                        child: const Text(
                          "Dessiner mon trajet",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(200, 40),
                            backgroundColor:
                                CustomColorScheme.customPrimaryColor),
                        onPressed: () => {
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .changeWidget(SubComponentCreateItineraryPage
                                      .pickItineraryWidget),
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .getDirectionsForPoints(),
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .alternative = true,
                            },
                        child: const Text(
                          "Recommendation de trajet",
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size(100, 40),
                            backgroundColor:
                                CustomColorScheme.customBackground),
                        onPressed: () => {
                              BlocProvider.of<MapCreateItineraryCubit>(context)
                                  .changeWidget(SubComponentCreateItineraryPage
                                      .startEndWidget)
                            },
                        child: const Text(
                          "Retour",
                          style: TextStyle(
                              color: CustomColorScheme.customOnSurface),
                        )),
                  ])));
    });
  }
}
