import 'package:copains_de_route/components/create_itinerary_widgets/choose_itinerary_widget.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/draw_itinerary.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/pick_itinerary.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/start_end_widget.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  CustomMapState createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  late GoogleMapController mapController;
  Marker _start = const Marker(markerId: MarkerId("1"));
  Marker _end = const Marker(markerId: MarkerId("2"));
  Future<List<PolylineResult>>? _info;
  late double _zoom;
  late Future<Position> position;
  String markerId = "";
  bool displayWarning = false;
  late int selectedWidget;

  @override
  void initState() {
    super.initState();
    _zoom = 11.0;
    selectedWidget = 0;
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

  void _getDirections() async {
    setState(() {
      _info = PolylinePoints().getRouteWithAlternatives(
          request: PolylineRequest(
        apiKey: "YOUR_API_KEY",
        origin:
            PointLatLng(_start.position.latitude, _start.position.longitude),
        destination:
            PointLatLng(_end.position.latitude, _end.position.longitude),
        alternatives: true,
        avoidFerries: true,
        avoidHighways: true,
        avoidTolls: true,
        mode: TravelMode.bicycling,
        wayPoints: List.empty(),
        optimizeWaypoints: false,
      ));
    });
  }

  void addMarker(LatLng pos, String markerId) {
    if (markerId == "" || (markerId != "start" && markerId != "end")) {
      return;
    }
    setState(() {
      if (markerId == "start") {
        _start = Marker(markerId: const MarkerId("start"), position: pos);
      } else if (markerId == "end") {
        _end = Marker(markerId: const MarkerId("end"), position: pos);
      } else {
        return;
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void changeView(SubComponentCreateItineraryPage key) {
    if (selectedWidget == 0) {
      if (_start.markerId.value == "1" || _end.markerId.value == "2") {
        setState(() {
          displayWarning = true;
        });
      } else {
        setState(() {
          selectedWidget = 1;
          displayWarning = false;
        });
      }
    }
    switch (key) {
      case SubComponentCreateItineraryPage.startEndWidget:
        setState(() {
          selectedWidget = 0;
        });
      case SubComponentCreateItineraryPage.choseItineraryWidget:
        setState(() {
          selectedWidget = 1;
        });
      case SubComponentCreateItineraryPage.pickItineraryWidget:
        setState(() {
          selectedWidget = 2;
        });
      case SubComponentCreateItineraryPage.drawItineraryWidget:
        setState(() {
          selectedWidget = 3;
        });
      default:
        break;
    }
  }

  void pressedStart() {
    markerId = "start";
  }

  void pressedEnd() {
    markerId = "end";
  }

  void pressedConfirm() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPositionUser(),
        builder: (context, obj) {
          if (!obj.hasData) {
            return const MaterialApp(
              home: CircularProgressIndicator(),
            );
          }
          return Builder(
              builder: (context) => Stack(children: [
                    FutureBuilder(
                        future: _info,
                        builder: (context, routes) {
                          if (!routes.hasData) {
                            return GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    obj.data!.latitude, obj.data!.longitude),
                                zoom: _zoom,
                              ),
                              markers: {
                                if (_start.markerId.value != "1") _start,
                                if (_end.markerId.value != "2") _end,
                              },
                              onTap: (evt) => addMarker(evt, markerId),
                            );
                          } else {
                            return GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      obj.data!.latitude, obj.data!.longitude),
                                  zoom: _zoom,
                                ),
                                markers: {
                                  if (_start.markerId.value != "1") _start,
                                  if (_end.markerId.value != "2") _end,
                                },
                                onTap: (evt) => addMarker(evt, markerId),
                                polylines: {
                                  Polyline(
                                      polylineId: const PolylineId('secondary'),
                                      color: Colors.blue,
                                      width: 5,
                                      points: routes.data![1].points
                                          .map((e) =>
                                              LatLng(e.latitude, e.longitude))
                                          .toList()),
                                  Polyline(
                                      polylineId: const PolylineId('overview'),
                                      color: Colors.red,
                                      width: 5,
                                      points: routes.data![0].points
                                          .map((e) =>
                                              LatLng(e.latitude, e.longitude))
                                          .toList())
                                });
                          }
                        }),
                    [
                      StartEndWidget(
                          changeView: changeView,
                          pressedStart: pressedStart,
                          pressedEnd: pressedEnd,
                          displayWarning: displayWarning),
                      ChoseItineraryTypeWidget(
                          changeView: changeView, getDirection: _getDirections),
                      DrawItineraryWidget(changeView: changeView),
                      PickItineraryWidget(changeView: changeView)
                    ][selectedWidget]
                  ]));
        });
  }
}
