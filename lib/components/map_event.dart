import 'dart:ui';

import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/event_details/event_details.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/cubit/login/login_cubit.dart';
import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:copains_de_route/cubit/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent extends StatefulWidget {
  const MapEvent({Key? key}) : super(key: key);

  @override
  State<MapEvent> createState() => MapEventState();
}

class MapEventState extends State<MapEvent> {
  BitmapDescriptor markerIconPublic = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIconPrivate = BitmapDescriptor.defaultMarker;
  late GoogleMapController mapController;
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListEventCubit>(context).getEvents();
    addCustomIconPublic();
    addCustomIconPrivate();
  }

  void addCustomIconPublic() async {
    markerIconPublic = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/marker_public.png', 100));
    setState(() {
      markerIconPublic = markerIconPublic;
    });
  }

  void addCustomIconPrivate() async {
    markerIconPrivate = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/marker_private.png', 100));
    setState(() {
      markerIconPrivate = markerIconPrivate;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionCubit, PositionState>(builder: (context, state) {
      if (state is PositionLoading) {
        return const LoadingWidget();
      } else {
        return BlocBuilder<ListEventCubit, ListEventState>(
            builder: (context, stateListEvent) {
          return SafeArea(
              child: Scaffold(
                  body: Column(children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => {
                          BlocProvider.of<ListEventCubit>(context).getEvents(),
                          Navigator.pop(context)
                        },
                    icon: const Icon(Icons.arrow_back, color: Colors.black)),
              ],
            ),
            Flexible(
                child: Stack(children: [
              GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: BlocProvider.of<PositionCubit>(context).position,
                  zoom: 11,
                ),
                markers: {
                  if (stateListEvent is ListAllEventsLoadedState ||
                      stateListEvent is ListEventsAroundLoadedState)
                    ...BlocProvider.of<ListEventCubit>(context)
                        .dataDisplayed
                        .eventList
                        .map((e) => Marker(
                            flat: false,
                            icon: e.visibility == "PRIVATE"
                                ? markerIconPrivate
                                : markerIconPublic,
                            markerId: MarkerId(e.id.toString()),
                            position: LatLng(
                                e.steps[0].latitude, e.steps[0].longitude),
                            infoWindow: InfoWindow(
                                title: e.name,
                                snippet: e.description,
                                onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return BlocProvider<DetailEventCubit>(
                                          create: (context) =>
                                              DetailEventCubit(event: e)
                                                ..updateJoined(context
                                                    .read<LoginCubit>()
                                                    .user),
                                          child: EventDetails(
                                              refreshList: () => {}));
                                    })))))
                        .toSet(),
                },
              ),
              IconButton(
                  onPressed: () => {
                        BlocProvider.of<ListEventCubit>(context)
                            .getEventsAround(
                          mapController,
                        ),
                      },
                  icon: const Icon(Icons.refresh))
            ]))
          ])));
        });
      }
    });
  }
}
