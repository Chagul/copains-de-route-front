import 'package:copains_de_route/components/custom_map.dart';
import 'package:flutter/material.dart';

class CreateItineraryPage extends StatelessWidget {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomMap(),
    );
  }
}
