import 'package:copains_de_route/components/map/map_cubit.dart';
import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:copains_de_route/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  CustomMapState createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  Set<Polyline> polylines = {};
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
        create: (_) => MapCubit(),
        child: BlocConsumer<PositionCubit, PositionState>(
            listener: (context, statePosition) {
          if (statePosition is PositionSuccess) {
            mapController.animateCamera(CameraUpdate.newLatLng(
              statePosition.latlng,
            ));
          }
        }, builder: (context, statePosition) {
          return BlocBuilder<MapCubit, MapState>(builder: (context, stateMap) {
            if (stateMap is MapPolylinesLoaded) {
              print("polylines loaded");
            }
            return Stack(children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: BlocProvider.of<PositionCubit>(context).position,
                  zoom: 11,
                ),
                markers: {
                  if (BlocProvider.of<MapCubit>(context).markerStart != null)
                    BlocProvider.of<MapCubit>(context).markerStart!,
                  if (BlocProvider.of<MapCubit>(context).markerEnd != null)
                    BlocProvider.of<MapCubit>(context).markerEnd!,
                  if (BlocProvider.of<MapCubit>(context).steps.isNotEmpty)
                    ...BlocProvider.of<MapCubit>(context).steps,
                },
                polylines: polylines,
                onTap: (evt) => BlocProvider.of<MapCubit>(context)
                    .addMarker(LatLng(evt.latitude, evt.longitude)),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: PointerInterceptor(
                    child: BlocProvider.of<MapCubit>(context).widgets[
                        BlocProvider.of<MapCubit>(context).selectedWidget],
                  ))
            ]);
          });
        }));
  }
}
