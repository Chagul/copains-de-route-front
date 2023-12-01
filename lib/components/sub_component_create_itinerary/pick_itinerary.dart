import 'package:copains_de_route/components/map/map_cubit.dart';
import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PickItineraryWidget extends StatelessWidget {
  @override
  const PickItineraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return Container(
          alignment: Alignment.bottomCenter,
          child: PointerInterceptor(
            child: Card(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "Distance: ${BlocProvider.of<MapCubit>(context).routeSelected.distance}")
                            ])),
                    Expanded(
                        flex: 2,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () =>
                                      BlocProvider.of<MapCubit>(context)
                                          .changeWidget(
                                              SubComponentCreateItineraryPage
                                                  .choseItineraryWidget),
                                  child: const Text(
                                    "Retour",
                                    style: TextStyle(color: Colors.black),
                                  )),
                              ElevatedButton(
                                  onPressed: () =>
                                      BlocProvider.of<MapCubit>(context)
                                          .changeWidget(
                                              SubComponentCreateItineraryPage
                                                  .pickItineraryWidget),
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
