import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomSwitchInput extends StatefulWidget {
  final String name1;
  final String name2;
  bool value;

  CustomSwitchInput(
      {super.key,
      required this.name1,
      required this.name2,
      required this.value});

  @override
  State<StatefulWidget> createState() => _CustomSwitchInputState();
}

class _CustomSwitchInputState extends State<CustomSwitchInput> {
  @override
  Widget build(Object context) {
    return Row(children: [
      Text(widget.name1, style: const TextStyle(color: Colors.black)),
      Switch(
        value: widget.value,
        activeColor: CustomColorScheme.customPrimaryColor,
        onChanged: (bool value) {
          setState(() {
            widget.value = value;
          });
        },
      ),
      Text(widget.name2, style: const TextStyle(color: Colors.black)),
    ]);
  }
}
