import 'dart:ui';

import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/components/event_details/event_details.dart';
import 'package:copains_de_route/cubit/detail_event/detail_event_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_cubit.dart';
import 'package:copains_de_route/cubit/list_event/list_events_state.dart';
import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:copains_de_route/cubit/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent extends StatelessWidget {
  const MapEvent({Key? key}) : super(key: key);

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
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: BlocProvider.of<PositionCubit>(context).position,
              zoom: 11,
            ),
            markers: {
              if (stateListEvent is ListAllEventsLoadedState)
                ...BlocProvider.of<ListEventCubit>(context)
                    .dataDisplayed
                    .eventList
                    .map((e) => Marker(
                        markerId: MarkerId(e.id.toString()),
                        position:
                            LatLng(e.steps[0].latitude, e.steps[0].longitude),
                        infoWindow: InfoWindow(
                            title: e.name,
                            snippet: e.description,
                            onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return BlocProvider(
                                      create: (context) =>
                                          DetailEventCubit(event: e),
                                      child: const EventDetails());
                                })))))
                    .toSet(),
            },
          );
        });
      }
    });
  }
}
