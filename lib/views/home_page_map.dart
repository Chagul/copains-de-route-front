import 'package:copains_de_route/views/mapSample.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageMap extends StatelessWidget {
  final Function changeView;
  const HomePageMap({super.key, required this.changeView});

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    Permission.location.request();

// You can also directly ask permission about its status.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map home'),
        ),
        body: MapSample());
  }
}
