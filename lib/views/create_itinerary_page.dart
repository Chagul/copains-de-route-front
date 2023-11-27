import 'package:copains_de_route/components/custom_map.dart';
import 'package:copains_de_route/position/position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateItineraryPage extends StatelessWidget {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PositionCubit()..initPosition(),
      child: CustomMap(),
    );
  }
}
