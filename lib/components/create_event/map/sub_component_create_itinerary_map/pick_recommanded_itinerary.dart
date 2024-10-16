import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/cubit/create_event_global/create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PickRecommandedItinerary extends StatelessWidget {
  @override
  const PickRecommandedItinerary({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenColumn = [];
    return BlocBuilder<MapCreateItineraryCubit, MapCreateItineraryState>(
        builder: (context, state) {
      if (state is MapPolylinesLoading) {
        childrenColumn = [const LoadingWidget()];
      } else {
        childrenColumn = [
          (Text(
              "Distance: ${BlocProvider.of<MapCreateItineraryCubit>(context).routeSelected.distance}")),
          Text(
              "Durée : ${BlocProvider.of<MapCreateItineraryCubit>(context).routeSelected.duration}")
        ];
      }
      return Container(
          alignment: Alignment.bottomCenter,
          child: PointerInterceptor(
            child: Card(
              color: CustomColorScheme.customSecondaryColor,
              child: SizedBox(
                  height: 150,
                  width: 2000,
                  child: Column(children: [
                    const Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Confirmer la selection du trajet")
                            ])),
                    Expanded(
                        flex: 7,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...childrenColumn,
                                  ])
                            ])),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(100, 40),
                                          backgroundColor: CustomColorScheme
                                              .customBackground),
                                      onPressed: () => {
                                            BlocProvider.of<
                                                        MapCreateItineraryCubit>(
                                                    context)
                                                .clearPolyline(),
                                            BlocProvider.of<
                                                        MapCreateItineraryCubit>(
                                                    context)
                                                .changeWidget(
                                                    SubComponentCreateItineraryPage
                                                        .choseItineraryWidget),
                                          },
                                      child: const Text(
                                        "Retour",
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSurface),
                                      )),
                                  ElevatedButton(
                                      style: TextButton.styleFrom(
                                          minimumSize: const Size(100, 100),
                                          backgroundColor: CustomColorScheme
                                              .customBackground),
                                      onPressed: () => {
                                            BlocProvider.of<
                                                        CreateItineraryCubit>(
                                                    context)
                                                .addItinerarySelected(BlocProvider
                                                        .of<MapCreateItineraryCubit>(
                                                            context)
                                                    .routeSelected),
                                            BlocProvider.of<
                                                        CreateItineraryCubit>(
                                                    context)
                                                .addSteps(
                                              BlocProvider.of<
                                                          MapCreateItineraryCubit>(
                                                      context)
                                                  .steps,
                                              BlocProvider.of<
                                                          MapCreateItineraryCubit>(
                                                      context)
                                                  .markerStart!,
                                              BlocProvider.of<
                                                          MapCreateItineraryCubit>(
                                                      context)
                                                  .markerEnd!,
                                            )
                                          },
                                      child: const Text(
                                        "Confirmer",
                                        style: TextStyle(
                                            color: CustomColorScheme
                                                .customOnSurface),
                                      ))
                                ]))),
                  ])),
            ),
          ));
    });
  }
}
