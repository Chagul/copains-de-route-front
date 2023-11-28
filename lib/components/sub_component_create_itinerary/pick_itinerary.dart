import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PickItineraryWidget extends StatefulWidget {
  final Function changeView;
  final PolylineResult selectedRoute;
  @override
  const PickItineraryWidget(
      {super.key, required this.changeView, required this.selectedRoute});

  @override
  PickItineraryWidgetState createState() => PickItineraryWidgetState();
}

class PickItineraryWidgetState extends State<PickItineraryWidget> {
  @override
  Widget build(BuildContext context) {
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
                            Text("Distance: ${widget.selectedRoute.distance}")
                          ])),
                  Expanded(
                      flex: 2,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () => widget.changeView(
                                    SubComponentCreateItineraryPage
                                        .choseItineraryWidget),
                                child: const Text(
                                  "Retour",
                                  style: TextStyle(color: Colors.black),
                                )),
                            ElevatedButton(
                                onPressed: () => widget.changeView(
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
  }
}
