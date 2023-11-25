import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberInput extends StatefulWidget {
  final String name;
  TextEditingController value;

  CustomNumberInput({super.key, required this.name, required this.value});

  @override
  State<StatefulWidget> createState() => _CustomNumberInputState();
}

class _CustomNumberInputState extends State<CustomNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        widget.name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 70.0,
        child: TextField(
          controller: widget.value,
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
