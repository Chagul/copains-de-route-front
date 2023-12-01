import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomCategoryTitle extends StatelessWidget {
  final String name;

  const CustomCategoryTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name,
        style: const TextStyle(
            color: CustomColorScheme.customPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18));
  }
}
