import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickStartEndItinerary extends StatelessWidget {
  @override
  const PickStartEndItinerary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCreateItineraryCubit, MapCreateItineraryState>(
        listener: (context, state) {
      if (state is DisplayWarning) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.warning)));
      }
    }, builder: (context, state) {
      return Card(
        color: CustomColorScheme.customSecondaryColor,
        child: SizedBox(
            height: 200,
            width: 250,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          textAlign: TextAlign.center,
                          "Cliquez sur la map après avoir choisi départ ou arrivée !")),
                  TextButton(
                      style: TextButton.styleFrom(
                          side: state is PickStartState
                              ? const BorderSide(
                                  color: CustomColorScheme.customOnPrimary)
                              : null,
                          minimumSize: const Size(100, 40),
                          backgroundColor:
                              CustomColorScheme.customPrimaryColor),
                      onPressed: () =>
                          BlocProvider.of<MapCreateItineraryCubit>(context)
                              .startPickStart(),
                      child: const Text(
                        "Départ",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      style: TextButton.styleFrom(
                          side: state is PickEndState
                              ? const BorderSide(
                                  color: CustomColorScheme.customOnPrimary)
                              : null,
                          minimumSize: const Size(100, 40),
                          backgroundColor:
                              CustomColorScheme.customPrimaryColor),
                      onPressed: () =>
                          BlocProvider.of<MapCreateItineraryCubit>(context)
                              .startPickEnd(),
                      child: const Text(
                        "Arrivée",
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(100, 40),
                          backgroundColor: CustomColorScheme.customOnPrimary),
                      onPressed: () =>
                          BlocProvider.of<MapCreateItineraryCubit>(context)
                              .changeWidget(SubComponentCreateItineraryPage
                                  .choseItineraryWidget),
                      child: const Text(
                        "Confirmer",
                        style:
                            TextStyle(color: CustomColorScheme.customOnSurface),
                      )),
                ])),
      );
    });
  }
}
