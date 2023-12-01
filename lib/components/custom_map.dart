import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:copains_de_route/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  CustomMapCreateItineraryState createState() =>
      CustomMapCreateItineraryState();
}

class CustomMapCreateItineraryState extends State<CustomMap> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCreateItineraryCubit>(
        create: (_) => MapCreateItineraryCubit(),
        child: BlocConsumer<PositionCubit, PositionState>(
            listener: (context, statePosition) {
          if (statePosition is PositionSuccess) {
            mapController.animateCamera(CameraUpdate.newLatLng(
              statePosition.latlng,
            ));
          }
        }, builder: (context, statePosition) {
          return BlocBuilder<MapCreateItineraryCubit, MapCreateItineraryState>(
              builder: (context, stateMap) {
            if (stateMap is PolylineSelected) {
              BlocProvider.of<MapCreateItineraryCubit>(context).buildPolyline();
            }
            return Stack(children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: BlocProvider.of<PositionCubit>(context).position,
                  zoom: 11,
                ),
                markers: {
                  if (BlocProvider.of<MapCreateItineraryCubit>(context)
                          .markerStart !=
                      null)
                    BlocProvider.of<MapCreateItineraryCubit>(context)
                        .markerStart!,
                  if (BlocProvider.of<MapCreateItineraryCubit>(context)
                          .markerEnd !=
                      null)
                    BlocProvider.of<MapCreateItineraryCubit>(context)
                        .markerEnd!,
                  if (BlocProvider.of<MapCreateItineraryCubit>(context)
                      .steps
                      .isNotEmpty)
                    ...BlocProvider.of<MapCreateItineraryCubit>(context).steps,
                },
                polylines:
                    BlocProvider.of<MapCreateItineraryCubit>(context).polylines,
                onTap: (evt) =>
                    BlocProvider.of<MapCreateItineraryCubit>(context)
                        .addMarker(LatLng(evt.latitude, evt.longitude)),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: PointerInterceptor(
                    child: BlocProvider.of<MapCreateItineraryCubit>(context)
                            .widgets[
                        BlocProvider.of<MapCreateItineraryCubit>(context)
                            .selectedWidget],
                  ))
            ]);
          });
        }));
  }
}
