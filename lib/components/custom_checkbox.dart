import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  String name;
  bool value;
  Function updateBoolean;

  CustomCheckbox({
    super.key,
    required this.name,
    required this.value,
    required this.updateBoolean,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return CustomColorScheme.customOnSurface;
      }
      return CustomColorScheme.customOnPrimary;
    }

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Row(
        children: [
          Checkbox(
              value: widget.value,
              checkColor: CustomColorScheme.customOnSecondary,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              onChanged: (bool? change) {
                widget.updateBoolean(change);
              }),
          Text(widget.name, style: const TextStyle(color: Colors.black)),
        ],
      );
    });
  }
}
