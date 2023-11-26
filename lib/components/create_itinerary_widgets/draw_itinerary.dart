import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class DrawItineraryWidget extends StatefulWidget {
  final Function changeView;
  final Function getDirection;
  final Function clearSteps;
  @override
  const DrawItineraryWidget(
      {super.key,
      required this.changeView,
      required this.getDirection,
      required this.clearSteps});

  @override
  DrawItineraryWidgetState createState() => DrawItineraryWidgetState();
}

class DrawItineraryWidgetState extends State<DrawItineraryWidget> {
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
                            onPressed: () => widget.getDirection(),
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
                                  widget.clearSteps(),
                                  widget.changeView(
                                      SubComponentCreateItineraryPage
                                          .choseItineraryWidget)
                                },
                            child: const Text(
                              "Retour",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () => {
                                  widget.getDirection(),
                                  widget.changeView(
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
