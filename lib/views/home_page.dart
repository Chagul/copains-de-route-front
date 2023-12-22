import 'package:copains_de_route/theme/custom_color_scheme.dart';
import 'package:copains_de_route/views/home_page_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColorScheme.customBackground,
      body: HomePageList(),
    );
  }
}
