import 'package:copains_de_route/model/event.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        SingleChildScrollView(
          child: Text(
            event.name,
            style: TextStyle(color: Colors.black),
          ),
        )
      ]),
    );
  }
}
