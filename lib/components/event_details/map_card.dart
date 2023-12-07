import 'package:copains_de_route/model/event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapCard extends StatelessWidget {
  final Event event;

  const MapCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Card(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.30,
              child: AbsorbPointer(
                child: GoogleMap(
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          event.steps[0].latitude, event.steps[0].longitude),
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
                        position: LatLng(
                            event.steps[0].latitude, event.steps[0].longitude),
                      ),
                      Marker(
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                        markerId: const MarkerId('arrivée'),
                        position: LatLng(
                            event.steps[event.steps.length - 1].latitude,
                            event.steps[event.steps.length - 1].longitude),
                      ),
                    }),
              )))
    ]);
  }
}
