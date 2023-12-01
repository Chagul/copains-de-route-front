import 'package:copains_de_route/components/map.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageMap extends StatelessWidget {
  final Function changeView;
  const HomePageMap({super.key, required this.changeView});

  @override
  Widget build(BuildContext context) {
    Permission.location.request();

    return const Scaffold(body: Map());
  }
}
