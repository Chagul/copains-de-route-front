import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class StartEndWidget extends StatefulWidget {
  final Function changeView;
  final Function pressedStart;
  final Function pressedEnd;
  final bool displayWarning;
  @override
  const StartEndWidget(
      {super.key,
      required this.changeView,
      required this.pressedStart,
      required this.pressedEnd,
      required this.displayWarning});

  @override
  StartEndWidgetState createState() => StartEndWidgetState();
}

class StartEndWidgetState extends State<StartEndWidget> {
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
                          onPressed: () => widget.pressedStart(),
                          child: const Text("depart")),
                      TextButton(
                          onPressed: () => widget.pressedEnd(),
                          child: const Text("arrivé")),
                      if (widget.displayWarning)
                        const Text("Veuillez choisir un départ et une arrivée"),
                      ElevatedButton(
                          onPressed: () => widget.changeView(
                              SubComponentCreateItineraryPage
                                  .choseItineraryWidget),
                          child: const Text(
                            "Confirmer",
                            style: TextStyle(color: Colors.black),
                          )),
                    ])),
          ),
        ));
  }
}
