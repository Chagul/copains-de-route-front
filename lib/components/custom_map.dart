import 'package:copains_de_route/components/map/map_cubit.dart';
import 'package:copains_de_route/components/map/map_state.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:copains_de_route/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  CustomMapState createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
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
            mapController.moveCamera(CameraUpdate.newLatLng(LatLng(
                statePosition.latlng.longitude,
                statePosition.latlng.latitude)));
          }
        }, builder: (context, statePosition) {
          return BlocBuilder<MapCubit, MapState>(builder: (context, stateMap) {
            if (stateMap is MapValidated) {
              //widget = CreateEventForm();
            }
            return Stack(children: [
              GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: BlocProvider.of<PositionCubit>(context).position,
                    zoom: 11,
                  )),
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
