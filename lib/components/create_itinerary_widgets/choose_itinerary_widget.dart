import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ChoseItineraryTypeWidget extends StatefulWidget {
  final Function changeView;
  final Function getDirection;
  @override
  const ChoseItineraryTypeWidget(
      {super.key, required this.changeView, required this.getDirection});

  @override
  ChoseItineraryTypeWidgetState createState() =>
      ChoseItineraryTypeWidgetState();
}

class ChoseItineraryTypeWidgetState extends State<ChoseItineraryTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: PointerInterceptor(
          child: Card(
            child: SizedBox(
                height: 200,
                width: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () => widget.changeView(
                              SubComponentCreateItineraryPage
                                  .drawItineraryWidget),
                          child: const Text("Dessiner mon trajet")),
                      TextButton(
                          onPressed: () => {
                                widget.getDirection(),
                                widget.changeView(
                                    SubComponentCreateItineraryPage
                                        .pickItineraryWidget)
                              },
                          child: const Text("Recommendation de trajet")),
                      ElevatedButton(
                          onPressed: () => widget.changeView(
                              SubComponentCreateItineraryPage.startEndWidget),
                          child: const Text(
                            "Retour",
                            style: TextStyle(color: Colors.black),
                          )),
                    ])),
          ),
        ));
  }
}
