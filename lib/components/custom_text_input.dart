import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String name;
  final int minLines;
  final int maxLines;
  TextEditingController value;

  CustomTextInput(
      {super.key,
      required this.name,
      required this.minLines,
      required this.maxLines,
      required this.value});

  @override
  State<StatefulWidget> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      TextFormField(
        controller: widget.value,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: const InputDecoration(
          filled: true,
          fillColor: CustomColorScheme.customOnPrimary,
        ),
        style: const TextStyle(color: CustomColorScheme.customOnSecondary),
      )
    ]);
  }
}
