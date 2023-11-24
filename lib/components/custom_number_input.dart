import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberInput extends StatelessWidget {
  final String name;

  const CustomNumberInput({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 70.0,
        child: TextField(
          decoration: const InputDecoration(
            filled: true,
            fillColor: CustomColorScheme.customOnPrimary,
          ),
          style: const TextStyle(color: CustomColorScheme.customOnSecondary),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      )
    ]);
  }
}
