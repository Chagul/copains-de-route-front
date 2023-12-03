import 'package:copains_de_route/components/commons/loading_widget.dart';
import 'package:copains_de_route/cubit/create_event_global/create_itinerary_cubit.dart';
import 'package:copains_de_route/cubit/create_event_global/create_itinerary_state.dart';
import 'package:copains_de_route/components/create_event/form/create_event_form.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_state.dart';
import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:copains_de_route/cubit/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MapWithBottomWidget extends StatefulWidget {
  const MapWithBottomWidget({Key? key}) : super(key: key);

  @override
  CustomMapCreateItineraryState createState() =>
      CustomMapCreateItineraryState();
}

class CustomMapCreateItineraryState extends State<MapWithBottomWidget> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final statePosition = context.watch<PositionCubit>().state;
      final stateMap = context.watch<MapCreateItineraryCubit>().state;
      final stateCreateItinerary = context.watch<CreateItineraryCubit>().state;

      if (stateCreateItinerary is CreateItineraryRouteValidated) {
        return const CreateEventForm();
      }
      if (statePosition is PositionLoading) {
        return const Center(child: LoadingWidget());
      } else {
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
                BlocProvider.of<MapCreateItineraryCubit>(context).markerStart!,
              if (BlocProvider.of<MapCreateItineraryCubit>(context).markerEnd !=
                  null)
                BlocProvider.of<MapCreateItineraryCubit>(context).markerEnd!,
              if (BlocProvider.of<MapCreateItineraryCubit>(context)
                  .steps
                  .isNotEmpty)
                ...BlocProvider.of<MapCreateItineraryCubit>(context).steps,
            },
            polylines:
                BlocProvider.of<MapCreateItineraryCubit>(context).polylines,
            onTap: (evt) => BlocProvider.of<MapCreateItineraryCubit>(context)
                .addMarker(LatLng(evt.latitude, evt.longitude)),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: PointerInterceptor(
                child:
                    BlocProvider.of<MapCreateItineraryCubit>(context).widgets[
                        BlocProvider.of<MapCreateItineraryCubit>(context)
                            .selectedWidget],
              ))
        ]);
      }
    });
  }
}
