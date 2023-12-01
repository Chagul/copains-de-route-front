import 'package:copains_de_route/components/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;

  late Future<Position> position;
  late Future<List<Object>> evt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPositionUser();
    });
  }

  Future<Position> _getPositionUser() {
    Future<Position> pos =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = pos;
    });
    return pos;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPositionUser(),
        builder: (context, obj) {
          if (!obj.hasData) {
            return const MaterialApp(
              home: LoadingWidget(),
            );
          }
          return MaterialApp(
              home: Scaffold(
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(obj.data!.latitude, obj.data!.longitude),
                zoom: 11.0,
              ),
            ),
          ));
        });
  }
}
