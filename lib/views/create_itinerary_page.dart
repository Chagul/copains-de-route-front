import 'package:copains_de_route/components/map_with_bottom_widget.dart';
import 'package:copains_de_route/cubit/create_event_global/create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/cubit/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateItineraryPage extends StatelessWidget {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PositionCubit>(
        create: (context) => PositionCubit()..initPosition(),
      ),
      BlocProvider<CreateItineraryCubit>(
        create: (context) => CreateItineraryCubit(),
      ),
      BlocProvider<MapCreateItineraryCubit>(
        create: (context) => MapCreateItineraryCubit(),
      )
    ], child: const Scaffold(body: MapWithBottomWidget()));
  }
}
