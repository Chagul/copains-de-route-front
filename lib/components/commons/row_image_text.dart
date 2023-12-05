import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class RowImageText extends StatelessWidget {
  final String image;
  final String text;
  const RowImageText({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
          radius: 30,
          backgroundColor: CustomColorScheme.customPrimaryColor,
          child:
              CircleAvatar(radius: 27, backgroundImage: NetworkImage(image))),
      const SizedBox(width: 10),
      Text(text,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
    ]);
  }
}
