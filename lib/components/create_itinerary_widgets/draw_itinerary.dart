import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class DrawItineraryWidget extends StatefulWidget {
  final Function changeView;
  @override
  const DrawItineraryWidget({super.key, required this.changeView});

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
                width: 200,
                child: Column(children: [
                  const Text("Veuillez dessiner"),
                  Row(children: [
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
                  ]),
                ])),
          ),
        ));
  }
}
