import 'dart:math';

import 'package:copains_de_route/components/create_itinerary_widgets/choose_itinerary_widget.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/draw_itinerary.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/pick_itinerary.dart';
import 'package:copains_de_route/components/create_itinerary_widgets/start_end_widget.dart';
import 'package:copains_de_route/components/loading_widget.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:copains_de_route/position/position_state.dart';
import 'package:copains_de_route/utils/enum_subcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  CustomMapState createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  /*late PositionBloc _positionBloc;
  late GoogleMapController mapController;
  Marker _start = const Marker(markerId: MarkerId("1"));
  Marker _end = const Marker(markerId: MarkerId("2"));
  Set<Marker> _step = {};
  Future<List<PolylineResult>>? _info;
  late double _zoom;
  late Future<Position> position;
  String markerId = "";
  bool displayWarning = false;
  late int selectedWidget;
  bool placeMarkerActivated = true;
  bool placeStepActivated = false;
  late PolylineResult selectedRoute;
  Color selectedColor = Colors.blue;
  Color notSelectedColor = Colors.grey;
  bool firstRoute = true;
  Set<Polyline> polylines = {};
  late int selectedIdRoute;
  bool alternative = false;

  @override
  void initState() {
    _positionBloc = PositionBloc();
    super.initState();
    _zoom = 11.0;
    selectedWidget = 0;
    selectedIdRoute = 0;
    selectedRoute = PolylineResult();
  }


  void _getDirections() async {
    setState(() {
      _info = PolylinePoints().getRouteWithAlternatives(
          request: PolylineRequest(
        apiKey: "AIzaSyBmTuVlxx7E58O3dVKioKprGaDK31mC4TE",
        origin:
            PointLatLng(_start.position.latitude, _start.position.longitude),
        destination:
            PointLatLng(_end.position.latitude, _end.position.longitude),
        alternatives: alternative,
        avoidFerries: true,
        avoidHighways: true,
        avoidTolls: true,
        mode: TravelMode.bicycling,
        wayPoints: _step
            .map((s) => PolylineWayPoint(
                location: "${s.position.latitude},${s.position.longitude}"))
            .toList(),
        optimizeWaypoints: false,
      ));
    });
  }

  void addMarker(LatLng pos, String markerId) {
    if (markerId == "" ||
        (markerId != "start" && markerId != "end") ||
        !placeMarkerActivated) {
      return;
    }
    setState(() {
      if (markerId == "start") {
        _start = Marker(
            markerId: const MarkerId("start"),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue));
      } else if (markerId == "end") {
        _end = Marker(
            markerId: const MarkerId("end"),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen));
      } else {
        return;
      }
    });
  }

  void addStep(LatLng pos) {
    setState(() {
      _step.add(Marker(
          markerId: MarkerId(pos.toString()),
          position: pos,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: _step.length.toString())));
      return;
    });
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
          placeMarkerActivated = true;
          placeStepActivated = false;
          _info = Future.value([]);
          selectedWidget = 0;
        });
      case SubComponentCreateItineraryPage.choseItineraryWidget:
        setState(() {
          placeMarkerActivated = false;
          placeStepActivated = false;
          selectedWidget = 1;
          _info = Future.value([]);
          _step = {};
        });
      case SubComponentCreateItineraryPage.drawItineraryWidget:
        setState(() {
          placeMarkerActivated = false;
          placeStepActivated = true;
          selectedWidget = 2;
        });
      case SubComponentCreateItineraryPage.pickItineraryWidget:
        setState(() {
          placeMarkerActivated = false;
          placeStepActivated = false;
          selectedWidget = 3;
        });
      default:
        break;
    }
    print(placeMarkerActivated);
    print(placeStepActivated);
  }

  void pressedStart() {
    markerId = "start";
  }

  void pressedEnd() {
    markerId = "end";
  }

  Set<Polyline> buildPolyline(List<PolylineResult> results) {
    polylines = {};
    for (int i = 0; i < results.length; i++) {
      polylines.add(Polyline(
          polylineId: PolylineId(i.toString()),
          color: selectedIdRoute == i || firstRoute
              ? selectedColor
              : notSelectedColor,
          zIndex: selectedIdRoute == i || firstRoute ? 2 : 1,
          width: 5,
          consumeTapEvents: true,
          onTap: () => setState(() {
                selectedRoute = results[i];
                selectedIdRoute = i;
              }),
          points: results[i]
              .points
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList()));
      if (firstRoute) {
        firstRoute = false;
      }
    }
    return polylines;
  }

  void clearSteps() {
    setState(() {});
  }*/

  late GoogleMapController mapController;
  bool _show = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocConsumer<PositionCubit, PositionState>(
          listener: (context, state) {
            if (state is PositionSuccess) {
              mapController.moveCamera(CameraUpdate.newLatLng(
                  LatLng(state.position.latitude, state.position.longitude)));
            } else if (state is PositionLoading) {
              _show = true;
            }
          },
          builder: (context, state) {
            return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(48.864716, 2.349014),
                  zoom: 11,
                ));
          },
        ),
        Visibility(visible: _show, child: LoadingWidget())
      ],
    ));
  }
}

    /*
      }
        
        future: _getPositionUser(),
        builder: (context, obj) {
          if (!obj.hasData) {
            return MaterialApp(
              home: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
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
                                if (_step.isNotEmpty) ..._step,
                              },
                              onTap: (evt) => {
                                if (placeMarkerActivated)
                                  {addMarker(evt, markerId)}
                                else if (placeStepActivated)
                                  {addStep(evt)}
                              },
                            );
                          } else {
                            polylines = buildPolyline(routes.data!);
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
                                  if (_step.isNotEmpty) ..._step,
                                },
                                onTap: (evt) => {
                                      if (placeMarkerActivated)
                                        {addMarker(evt, markerId)}
                                      else if (placeStepActivated)
                                        {addStep(evt)}
                                    },
                                polylines: polylines);
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
                      DrawItineraryWidget(
                        changeView: changeView,
                        getDirection: _getDirections,
                        clearSteps: clearSteps,
                      ),
                      PickItineraryWidget(
                          changeView: changeView, selectedRoute: selectedRoute)
                    ][selectedWidget]
                  ]));
        });
  }
}*/
