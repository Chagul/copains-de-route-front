import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxCustom extends StatefulWidget {
  String name;
  bool value;
  int height;
  int width;

  CheckboxCustom(
      {super.key,
      required this.name,
      required this.value,
      required this.height,
      required this.width});

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return CustomColorScheme.customOnSurface;
    }

    widget.value = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Row(
        children: [
          Text(widget.name,
              style: const TextStyle(color: CustomColorScheme.customOnSurface)),
          Checkbox(
              value: widget.value,
              checkColor: Colors.red,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              onChanged: (bool? change) {
                setState(() {
                  widget.value = change!;
                });
              }),
        ],
      );
    });
  }
}
