import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String name;
  final int minLines;
  final int maxLines;

  const CustomTextInput(
      {super.key,
      required this.name,
      required this.minLines,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        decoration: const InputDecoration(
          filled: true,
          fillColor: CustomColorScheme.customOnPrimary,
        ),
        style: const TextStyle(color: CustomColorScheme.customOnSecondary),
      )
    ]);
  }
}
