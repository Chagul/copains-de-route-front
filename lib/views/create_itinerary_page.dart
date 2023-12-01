import 'package:copains_de_route/components/create_event/create_event/create_itinerary_cubit.dart';
import 'package:copains_de_route/components/create_event/create_event/create_itinerary_state.dart';
import 'package:copains_de_route/components/create_event/map/cubit_map_create_itinerary/map_create_itinerary_cubit.dart';
import 'package:copains_de_route/components/custom_map.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateItineraryPage extends StatelessWidget {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PositionCubit>(
          create: (context) => PositionCubit()..initPosition(),
        ),
        BlocProvider<CreateItineraryCubit>(
          create: (context) => CreateItineraryCubit(),
        ),
        BlocProvider<MapCreateItineraryCubit>(
          create: (context) => MapCreateItineraryCubit(),
        )
      ],
      child: CustomMap(),
    );
  }
}
