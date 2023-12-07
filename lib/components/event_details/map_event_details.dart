import 'package:copains_de_route/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEventDetails extends StatelessWidget {
  final Event event;
  const MapEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          const Text("Trajet",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))
        ],
      ),
      Flexible(
          child: GoogleMap(
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(event.steps[0].latitude, event.steps[0].longitude),
                zoom: 12,
              ),
              polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              color: Colors.red,
              width: 3,
              points: PolylinePoints()
                  .decodePolyline(event.route)
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
          },
              markers: {
            Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              markerId: const MarkerId('départ'),
              position:
                  LatLng(event.steps[0].latitude, event.steps[0].longitude),
            ),
            for (int i = 1; i < event.steps.length - 3; i++)
              Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                markerId: MarkerId(event.steps[i].rank.toString()),
                position:
                    LatLng(event.steps[i].latitude, event.steps[i].longitude),
              ),
            Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              markerId: const MarkerId('arrivée'),
              position: LatLng(event.steps[event.steps.length - 1].latitude,
                  event.steps[event.steps.length - 1].longitude),
            ),
          }))
    ])));
  }
}
